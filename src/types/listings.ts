export interface Listing {
  id: string;
  title: string;
  description: string;
  price: number;
  location: string;
  property_type: 'rumah' | 'apartemen' | 'ruko' | 'tanah';
  status: 'tersedia' | 'terjual' | 'disewa';
  square_meters: number;
  bedrooms?: number;
  bathrooms?: number;
  created_at: string;
  updated_at: string;
  user_id: string;
  media?: PropertyMedia[];
}

export interface PropertyMedia {
  id: string;
  listing_id: string;
  media_url: string;
  media_type: 'photo' | 'video';
  is_primary: boolean;
  created_at: string;
}

export interface ListingFormData {
  title: string;
  description: string;
  price: number;
  location: string;
  property_type: 'rumah' | 'apartemen' | 'ruko' | 'tanah';
  status: 'tersedia' | 'terjual' | 'disewa';
  square_meters: number;
  bedrooms?: number;
  bathrooms?: number;
}

export interface MediaUpload {
  file: File;
  preview: string;
  type: 'photo' | 'video';
  is_primary?: boolean;
  uploading?: boolean;
  error?: string;
}

export interface ListingFilter {
  property_type?: string;
  status?: string;
  min_price?: number;
  max_price?: number;
  min_square_meters?: number;
  max_square_meters?: number;
  min_bedrooms?: number;
  search_term?: string;
}

export interface PaginationParams {
  page: number;
  limit: number;
}

export interface ListingResponse {
  data: Listing[];
  count: number;
  page: number;
  limit: number;
  totalPages: number;
}