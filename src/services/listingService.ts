import { supabase } from '../lib/supabase';
import { Listing, ListingFormData, ListingFilter, PaginationParams, MediaUpload } from '../types/listings';

export class ListingService {
  /**
   * Get all listings with pagination and filtering
   */
  async getListings(
    filters: ListingFilter = {},
    pagination: PaginationParams = { page: 1, limit: 10 }
  ) {
    try {
      // Calculate offset
      const { page, limit } = pagination;
      const offset = (page - 1) * limit;

      // Start building the query
      let query = supabase
        .from('listings')
        .select('*, property_media(*)', { count: 'exact' });

      // Apply filters
      if (filters.property_type) {
        query = query.eq('property_type', filters.property_type);
      }

      if (filters.status) {
        query = query.eq('status', filters.status);
      }

      if (filters.min_price) {
        query = query.gte('price', filters.min_price);
      }

      if (filters.max_price) {
        query = query.lte('price', filters.max_price);
      }

      if (filters.min_square_meters) {
        query = query.gte('square_meters', filters.min_square_meters);
      }

      if (filters.max_square_meters) {
        query = query.lte('square_meters', filters.max_square_meters);
      }

      if (filters.min_bedrooms) {
        query = query.gte('bedrooms', filters.min_bedrooms);
      }

      if (filters.search_term) {
        query = query.or(`title.ilike.%${filters.search_term}%,description.ilike.%${filters.search_term}%,location.ilike.%${filters.search_term}%`);
      }

      // Apply pagination
      const { data, error, count } = await query
        .order('created_at', { ascending: false })
        .range(offset, offset + limit - 1);

      if (error) throw error;

      return {
        data: data as Listing[],
        count: count || 0,
        page,
        limit,
        totalPages: Math.ceil((count || 0) / limit)
      };
    } catch (error) {
      console.error('Error fetching listings:', error);
      throw error;
    }
  }

  /**
   * Get a single listing by ID
   */
  async getListingById(id: string) {
    try {
      const { data, error } = await supabase
        .from('listings')
        .select('*, property_media(*)')
        .eq('id', id)
        .single();

      if (error) throw error;
      return data as Listing;
    } catch (error) {
      console.error(`Error fetching listing with ID ${id}:`, error);
      throw error;
    }
  }

  /**
   * Get listings for the current user
   */
  async getUserListings() {
    try {
      const { data: user } = await supabase.auth.getUser();
      
      if (!user.user) throw new Error('User not authenticated');

      const { data, error } = await supabase
        .from('listings')
        .select('*, property_media(*)')
        .eq('user_id', user.user.id)
        .order('created_at', { ascending: false });

      if (error) throw error;
      return data as Listing[];
    } catch (error) {
      console.error('Error fetching user listings:', error);
      throw error;
    }
  }

  /**
   * Create a new listing
   */
  async createListing(listingData: ListingFormData) {
    try {
      const { data: user } = await supabase.auth.getUser();
      
      if (!user.user) throw new Error('User not authenticated');

      const { data, error } = await supabase
        .from('listings')
        .insert({
          ...listingData,
          user_id: user.user.id
        })
        .select()
        .single();

      if (error) throw error;
      return data as Listing;
    } catch (error) {
      console.error('Error creating listing:', error);
      throw error;
    }
  }

  /**
   * Update an existing listing
   */
  async updateListing(id: string, listingData: Partial<ListingFormData>) {
    try {
      const { data, error } = await supabase
        .from('listings')
        .update(listingData)
        .eq('id', id)
        .select()
        .single();

      if (error) throw error;
      return data as Listing;
    } catch (error) {
      console.error(`Error updating listing with ID ${id}:`, error);
      throw error;
    }
  }

  /**
   * Delete a listing
   */
  async deleteListing(id: string) {
    try {
      const { error } = await supabase
        .from('listings')
        .delete()
        .eq('id', id);

      if (error) throw error;
      return true;
    } catch (error) {
      console.error(`Error deleting listing with ID ${id}:`, error);
      throw error;
    }
  }

  /**
   * Upload media for a listing
   */
  async uploadMedia(listingId: string, file: File, isPrimary: boolean = false) {
    try {
      // Generate a unique file name
      const fileExt = file.name.split('.').pop();
      const fileName = `${listingId}/${Date.now()}.${fileExt}`;
      const filePath = `property-media/${fileName}`;
      
      // Determine media type
      const mediaType = file.type.startsWith('image/') ? 'photo' : 'video';
      
      // Check file size
      if (mediaType === 'photo' && file.size > 5 * 1024 * 1024) {
        throw new Error('Ukuran foto melebihi batas maksimum 5MB');
      }
      
      if (mediaType === 'video' && file.size > 100 * 1024 * 1024) {
        throw new Error('Ukuran video melebihi batas maksimum 100MB');
      }
      
      // Check file format
      const allowedPhotoFormats = ['image/jpeg', 'image/png', 'image/webp'];
      const allowedVideoFormats = ['video/mp4', 'video/quicktime'];
      
      if (mediaType === 'photo' && !allowedPhotoFormats.includes(file.type)) {
        throw new Error('Format foto tidak didukung. Gunakan JPG, PNG, atau WEBP');
      }
      
      if (mediaType === 'video' && !allowedVideoFormats.includes(file.type)) {
        throw new Error('Format video tidak didukung. Gunakan MP4 atau MOV');
      }
      
      // Count existing media for this listing
      if (mediaType === 'photo') {
        const { count, error: countError } = await supabase
          .from('property_media')
          .select('*', { count: 'exact' })
          .eq('listing_id', listingId)
          .eq('media_type', 'photo');
          
        if (countError) throw countError;
        
        if (count && count >= 20) {
          throw new Error('Jumlah foto melebihi batas maksimum 20 foto');
        }
      }
      
      // Upload the file
      const { error: uploadError } = await supabase.storage
        .from('property-media')
        .upload(fileName, file);

      if (uploadError) throw uploadError;

      // Get the public URL
      const { data: publicURL } = supabase.storage
        .from('property-media')
        .getPublicUrl(fileName);

      // Insert media record
      const { data, error } = await supabase
        .from('property_media')
        .insert({
          listing_id: listingId,
          media_url: publicURL.publicUrl,
          media_type: mediaType,
          is_primary: isPrimary
        })
        .select()
        .single();

      if (error) throw error;
      return data;
    } catch (error) {
      console.error('Error uploading media:', error);
      throw error;
    }
  }

  /**
   * Delete media
   */
  async deleteMedia(mediaId: string) {
    try {
      // Get the media record first to get the URL
      const { data: media, error: fetchError } = await supabase
        .from('property_media')
        .select('media_url')
        .eq('id', mediaId)
        .single();

      if (fetchError) throw fetchError;

      // Extract the file path from the URL
      const url = new URL(media.media_url);
      const filePath = url.pathname.split('/').pop();

      // Delete from storage
      if (filePath) {
        const { error: storageError } = await supabase.storage
          .from('property-media')
          .remove([filePath]);

        if (storageError) console.error('Error removing file from storage:', storageError);
      }

      // Delete the record
      const { error } = await supabase
        .from('property_media')
        .delete()
        .eq('id', mediaId);

      if (error) throw error;
      return true;
    } catch (error) {
      console.error(`Error deleting media with ID ${mediaId}:`, error);
      throw error;
    }
  }

  /**
   * Set primary media
   */
  async setPrimaryMedia(listingId: string, mediaId: string) {
    try {
      // First, set all media for this listing to not primary
      const { error: updateError } = await supabase
        .from('property_media')
        .update({ is_primary: false })
        .eq('listing_id', listingId);

      if (updateError) throw updateError;

      // Then set the selected media as primary
      const { data, error } = await supabase
        .from('property_media')
        .update({ is_primary: true })
        .eq('id', mediaId)
        .select()
        .single();

      if (error) throw error;
      return data;
    } catch (error) {
      console.error(`Error setting primary media for listing ${listingId}:`, error);
      throw error;
    }
  }
}

export const listingService = new ListingService();