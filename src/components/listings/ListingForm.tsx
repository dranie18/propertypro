import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { ListingFormData, MediaUpload } from '../../types/listings';
import { listingService } from '../../services/listingService';
import { useNotification } from '../../contexts/NotificationContext';
import { 
  Home, 
  Building, 
  Store, 
  MapPin, 
  Upload, 
  X, 
  Image as ImageIcon, 
  Film, 
  Save, 
  ArrowLeft 
} from 'lucide-react';

interface ListingFormProps {
  initialData?: ListingFormData;
  listingId?: string;
  isEdit?: boolean;
}

const ListingForm: React.FC<ListingFormProps> = ({ 
  initialData, 
  listingId,
  isEdit = false 
}) => {
  const navigate = useNavigate();
  const { showSuccess, showError } = useNotification();
  
  const [formData, setFormData] = useState<ListingFormData>({
    title: '',
    description: '',
    price: 0,
    location: '',
    property_type: 'rumah',
    status: 'tersedia',
    square_meters: 0,
    bedrooms: undefined,
    bathrooms: undefined,
    ...initialData
  });

  const [errors, setErrors] = useState<Partial<Record<keyof ListingFormData, string>>>({});
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [mediaUploads, setMediaUploads] = useState<MediaUpload[]>([]);
  const [isUploading, setIsUploading] = useState(false);

  useEffect(() => {
    if (initialData) {
      setFormData(initialData);
    }
  }, [initialData]);

  const validateForm = (): boolean => {
    const newErrors: Partial<Record<keyof ListingFormData, string>> = {};
    
    // Title validation
    if (!formData.title) {
      newErrors.title = 'Judul wajib diisi';
    } else if (formData.title.length < 10) {
      newErrors.title = 'Judul minimal 10 karakter';
    } else if (formData.title.length > 100) {
      newErrors.title = 'Judul maksimal 100 karakter';
    }
    
    // Description validation
    if (!formData.description) {
      newErrors.description = 'Deskripsi wajib diisi';
    } else if (formData.description.length < 50) {
      newErrors.description = 'Deskripsi minimal 50 karakter';
    }
    
    // Price validation
    if (!formData.price) {
      newErrors.price = 'Harga wajib diisi';
    } else if (formData.price <= 0) {
      newErrors.price = 'Harga harus lebih dari 0';
    }
    
    // Location validation
    if (!formData.location) {
      newErrors.location = 'Lokasi wajib diisi';
    } else if (formData.location.length < 5) {
      newErrors.location = 'Lokasi minimal 5 karakter';
    }
    
    // Square meters validation
    if (!formData.square_meters) {
      newErrors.square_meters = 'Luas bangunan wajib diisi';
    } else if (formData.square_meters <= 0) {
      newErrors.square_meters = 'Luas bangunan harus lebih dari 0';
    }
    
    setErrors(newErrors);
    return Object.keys(newErrors).length === 0;
  };

  const handleInputChange = (e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement | HTMLSelectElement>) => {
    const { name, value, type } = e.target;
    
    // Convert numeric values
    if (type === 'number') {
      setFormData({
        ...formData,
        [name]: value ? parseFloat(value) : ''
      });
    } else {
      setFormData({
        ...formData,
        [name]: value
      });
    }
    
    // Clear error when field is edited
    if (errors[name as keyof ListingFormData]) {
      setErrors({
        ...errors,
        [name]: undefined
      });
    }
  };

  const handleMediaChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const files = e.target.files;
    if (!files || files.length === 0) return;
    
    // Check if adding these files would exceed the limit
    const photoCount = mediaUploads.filter(m => m.type === 'photo').length;
    const newPhotoCount = Array.from(files).filter(f => f.type.startsWith('image/')).length;
    
    if (photoCount + newPhotoCount > 20) {
      showError('Batas Maksimum', 'Jumlah foto melebihi batas maksimum 20 foto');
      return;
    }
    
    // Process each file
    Array.from(files).forEach(file => {
      // Determine file type
      const isImage = file.type.startsWith('image/');
      const isVideo = file.type.startsWith('video/');
      
      if (!isImage && !isVideo) {
        showError('Format Tidak Didukung', 'Format file tidak didukung. Gunakan JPG, PNG, WEBP untuk foto atau MP4, MOV untuk video');
        return;
      }
      
      // Check file size
      if (isImage && file.size > 5 * 1024 * 1024) {
        showError('Ukuran File', 'Ukuran foto melebihi batas maksimum 5MB');
        return;
      }
      
      if (isVideo && file.size > 100 * 1024 * 1024) {
        showError('Ukuran File', 'Ukuran video melebihi batas maksimum 100MB');
        return;
      }
      
      // Check video count
      if (isVideo && mediaUploads.some(m => m.type === 'video')) {
        showError('Batas Video', 'Hanya diperbolehkan 1 video per properti');
        return;
      }
      
      // Create preview URL
      const preview = URL.createObjectURL(file);
      
      // Add to uploads
      setMediaUploads(prev => [
        ...prev, 
        {
          file,
          preview,
          type: isImage ? 'photo' : 'video',
          is_primary: prev.length === 0 // First upload is primary by default
        }
      ]);
    });
    
    // Reset the input
    e.target.value = '';
  };

  const removeMedia = (index: number) => {
    const mediaToRemove = mediaUploads[index];
    
    // Revoke object URL to prevent memory leaks
    URL.revokeObjectURL(mediaToRemove.preview);
    
    // Remove from state
    setMediaUploads(prev => {
      const newUploads = prev.filter((_, i) => i !== index);
      
      // If we removed the primary media, set the first one as primary
      if (mediaToRemove.is_primary && newUploads.length > 0) {
        newUploads[0].is_primary = true;
      }
      
      return newUploads;
    });
  };

  const setPrimaryMedia = (index: number) => {
    setMediaUploads(prev => 
      prev.map((media, i) => ({
        ...media,
        is_primary: i === index
      }))
    );
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    
    if (!validateForm()) {
      showError('Validasi Gagal', 'Mohon perbaiki kesalahan pada form');
      return;
    }
    
    setIsSubmitting(true);
    
    try {
      let listing;
      
      if (isEdit && listingId) {
        // Update existing listing
        listing = await listingService.updateListing(listingId, formData);
        showSuccess('Berhasil', 'Properti berhasil diperbarui');
      } else {
        // Create new listing
        listing = await listingService.createListing(formData);
        showSuccess('Berhasil', 'Properti berhasil ditambahkan');
      }
      
      // Upload media files if any
      if (mediaUploads.length > 0 && listing) {
        setIsUploading(true);
        
        for (const media of mediaUploads) {
          try {
            await listingService.uploadMedia(
              listing.id,
              media.file,
              media.is_primary
            );
          } catch (error: any) {
            showError('Gagal Mengunggah Media', error.message || 'Terjadi kesalahan saat mengunggah media');
          }
        }
        
        setIsUploading(false);
      }
      
      // Navigate to listing detail
      navigate(`/listings/${listing.id}`);
    } catch (error: any) {
      showError(
        'Gagal Menyimpan', 
        error.message || 'Terjadi kesalahan saat menyimpan properti'
      );
    } finally {
      setIsSubmitting(false);
    }
  };

  const getPropertyTypeIcon = (type: string) => {
    switch (type) {
      case 'rumah':
        return <Home size={20} />;
      case 'apartemen':
        return <Building size={20} />;
      case 'ruko':
        return <Store size={20} />;
      case 'tanah':
        return <MapPin size={20} />;
      default:
        return <Home size={20} />;
    }
  };

  return (
    <div className="bg-white rounded-lg shadow-md p-6">
      <form onSubmit={handleSubmit}>
        <div className="mb-6">
          <h2 className="text-xl font-semibold text-neutral-900 mb-2">
            {isEdit ? 'Edit Properti' : 'Tambah Properti Baru'}
          </h2>
          <p className="text-neutral-600">
            {isEdit 
              ? 'Perbarui informasi properti Anda' 
              : 'Isi semua informasi yang diperlukan untuk menambahkan properti baru'}
          </p>
        </div>

        {/* Basic Information */}
        <div className="mb-6">
          <h3 className="text-lg font-medium text-neutral-800 mb-4">Informasi Dasar</h3>
          
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4 mb-4">
            <div>
              <label htmlFor="title" className="block text-sm font-medium text-neutral-700 mb-1">
                Judul Properti <span className="text-red-500">*</span>
              </label>
              <input
                type="text"
                id="title"
                name="title"
                value={formData.title}
                onChange={handleInputChange}
                className={`w-full px-4 py-2 border rounded-lg focus:ring-2 focus:ring-primary ${
                  errors.title ? 'border-red-500 focus:ring-red-500' : 'border-neutral-300 focus:ring-primary/50'
                }`}
                placeholder="Contoh: Rumah Minimalis 2 Lantai di Jakarta Selatan"
                required
              />
              {errors.title && (
                <p className="mt-1 text-sm text-red-500">{errors.title}</p>
              )}
              <p className="mt-1 text-xs text-neutral-500">
                Minimal 10 karakter, maksimal 100 karakter
              </p>
            </div>
            
            <div>
              <label htmlFor="property_type" className="block text-sm font-medium text-neutral-700 mb-1">
                Tipe Properti <span className="text-red-500">*</span>
              </label>
              <div className="relative">
                <select
                  id="property_type"
                  name="property_type"
                  value={formData.property_type}
                  onChange={handleInputChange}
                  className="w-full px-4 py-2 border border-neutral-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary/50 appearance-none"
                  required
                >
                  <option value="rumah">Rumah</option>
                  <option value="apartemen">Apartemen</option>
                  <option value="ruko">Ruko</option>
                  <option value="tanah">Tanah</option>
                </select>
                <div className="absolute inset-y-0 right-0 flex items-center pr-3 pointer-events-none">
                  {getPropertyTypeIcon(formData.property_type)}
                </div>
              </div>
            </div>
          </div>
          
          <div className="mb-4">
            <label htmlFor="description" className="block text-sm font-medium text-neutral-700 mb-1">
              Deskripsi <span className="text-red-500">*</span>
            </label>
            <textarea
              id="description"
              name="description"
              value={formData.description}
              onChange={handleInputChange}
              rows={5}
              className={`w-full px-4 py-2 border rounded-lg focus:ring-2 focus:ring-primary ${
                errors.description ? 'border-red-500 focus:ring-red-500' : 'border-neutral-300 focus:ring-primary/50'
              }`}
              placeholder="Deskripsikan properti Anda secara detail..."
              required
            />
            {errors.description && (
              <p className="mt-1 text-sm text-red-500">{errors.description}</p>
            )}
            <p className="mt-1 text-xs text-neutral-500">
              Minimal 50 karakter. Sertakan informasi penting seperti kondisi properti, fasilitas, dan keunggulan.
            </p>
          </div>
          
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            <div>
              <label htmlFor="price" className="block text-sm font-medium text-neutral-700 mb-1">
                Harga (Rp) <span className="text-red-500">*</span>
              </label>
              <input
                type="number"
                id="price"
                name="price"
                value={formData.price}
                onChange={handleInputChange}
                className={`w-full px-4 py-2 border rounded-lg focus:ring-2 focus:ring-primary ${
                  errors.price ? 'border-red-500 focus:ring-red-500' : 'border-neutral-300 focus:ring-primary/50'
                }`}
                placeholder="Contoh: 500000000"
                min="0"
                step="1000000"
                required
              />
              {errors.price && (
                <p className="mt-1 text-sm text-red-500">{errors.price}</p>
              )}
            </div>
            
            <div>
              <label htmlFor="status" className="block text-sm font-medium text-neutral-700 mb-1">
                Status <span className="text-red-500">*</span>
              </label>
              <select
                id="status"
                name="status"
                value={formData.status}
                onChange={handleInputChange}
                className="w-full px-4 py-2 border border-neutral-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary/50"
                required
              >
                <option value="tersedia">Tersedia</option>
                <option value="terjual">Terjual</option>
                <option value="disewa">Disewa</option>
              </select>
            </div>
          </div>
        </div>

        {/* Location */}
        <div className="mb-6">
          <h3 className="text-lg font-medium text-neutral-800 mb-4">Lokasi</h3>
          
          <div className="mb-4">
            <label htmlFor="location" className="block text-sm font-medium text-neutral-700 mb-1">
              Alamat Lengkap <span className="text-red-500">*</span>
            </label>
            <textarea
              id="location"
              name="location"
              value={formData.location}
              onChange={handleInputChange}
              rows={2}
              className={`w-full px-4 py-2 border rounded-lg focus:ring-2 focus:ring-primary ${
                errors.location ? 'border-red-500 focus:ring-red-500' : 'border-neutral-300 focus:ring-primary/50'
              }`}
              placeholder="Contoh: Jl. Sudirman No. 123, Kecamatan Setia Budi, Jakarta Selatan"
              required
            />
            {errors.location && (
              <p className="mt-1 text-sm text-red-500">{errors.location}</p>
            )}
            <p className="mt-1 text-xs text-neutral-500">
              Minimal 5 karakter. Sertakan nama jalan, nomor, kecamatan, dan kota.
            </p>
          </div>
        </div>

        {/* Property Details */}
        <div className="mb-6">
          <h3 className="text-lg font-medium text-neutral-800 mb-4">Detail Properti</h3>
          
          <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
            <div>
              <label htmlFor="square_meters" className="block text-sm font-medium text-neutral-700 mb-1">
                Luas Bangunan (m²) <span className="text-red-500">*</span>
              </label>
              <input
                type="number"
                id="square_meters"
                name="square_meters"
                value={formData.square_meters}
                onChange={handleInputChange}
                className={`w-full px-4 py-2 border rounded-lg focus:ring-2 focus:ring-primary ${
                  errors.square_meters ? 'border-red-500 focus:ring-red-500' : 'border-neutral-300 focus:ring-primary/50'
                }`}
                placeholder="Contoh: 150"
                min="0"
                required
              />
              {errors.square_meters && (
                <p className="mt-1 text-sm text-red-500">{errors.square_meters}</p>
              )}
            </div>
            
            {(formData.property_type === 'rumah' || formData.property_type === 'apartemen') && (
              <>
                <div>
                  <label htmlFor="bedrooms" className="block text-sm font-medium text-neutral-700 mb-1">
                    Kamar Tidur
                  </label>
                  <input
                    type="number"
                    id="bedrooms"
                    name="bedrooms"
                    value={formData.bedrooms || ''}
                    onChange={handleInputChange}
                    className="w-full px-4 py-2 border border-neutral-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary/50"
                    placeholder="Contoh: 3"
                    min="0"
                  />
                </div>
                
                <div>
                  <label htmlFor="bathrooms" className="block text-sm font-medium text-neutral-700 mb-1">
                    Kamar Mandi
                  </label>
                  <input
                    type="number"
                    id="bathrooms"
                    name="bathrooms"
                    value={formData.bathrooms || ''}
                    onChange={handleInputChange}
                    className="w-full px-4 py-2 border border-neutral-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary/50"
                    placeholder="Contoh: 2"
                    min="0"
                  />
                </div>
              </>
            )}
          </div>
        </div>

        {/* Media Upload */}
        <div className="mb-6">
          <h3 className="text-lg font-medium text-neutral-800 mb-4">Foto & Video</h3>
          
          <div className="mb-4">
            <label className="block text-sm font-medium text-neutral-700 mb-2">
              Unggah Foto & Video
            </label>
            <div className="border-2 border-dashed border-neutral-300 rounded-lg p-6 text-center hover:bg-neutral-50 transition-colors">
              <input
                type="file"
                id="media"
                onChange={handleMediaChange}
                className="hidden"
                accept="image/jpeg,image/png,image/webp,video/mp4,video/quicktime"
                multiple
              />
              <label htmlFor="media" className="cursor-pointer block">
                <Upload size={32} className="mx-auto text-neutral-400 mb-2" />
                <p className="text-neutral-600 mb-1">
                  Klik untuk mengunggah atau drag & drop
                </p>
                <p className="text-sm text-neutral-500">
                  Foto: JPG, PNG, WEBP (maks. 5MB) | Video: MP4, MOV (maks. 100MB)
                </p>
              </label>
            </div>
            <p className="mt-2 text-xs text-neutral-500">
              Maksimal 20 foto dan 1 video per properti. Foto pertama akan menjadi foto utama.
            </p>
          </div>
          
          {mediaUploads.length > 0 && (
            <div>
              <h4 className="text-sm font-medium text-neutral-700 mb-2">
                Media yang Diunggah ({mediaUploads.length})
              </h4>
              <div className="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-5 gap-4">
                {mediaUploads.map((media, index) => (
                  <div 
                    key={index} 
                    className={`relative rounded-lg overflow-hidden border-2 ${
                      media.is_primary ? 'border-primary' : 'border-neutral-200'
                    }`}
                  >
                    {media.type === 'photo' ? (
                      <div className="aspect-square">
                        <img 
                          src={media.preview} 
                          alt={`Preview ${index}`} 
                          className="w-full h-full object-cover"
                        />
                      </div>
                    ) : (
                      <div className="aspect-square bg-neutral-800 flex items-center justify-center">
                        <Film size={32} className="text-white" />
                      </div>
                    )}
                    
                    <div className="absolute top-2 right-2 flex space-x-1">
                      <button
                        type="button"
                        onClick={() => removeMedia(index)}
                        className="p-1 bg-red-500 text-white rounded-full hover:bg-red-600"
                        title="Hapus"
                      >
                        <X size={14} />
                      </button>
                    </div>
                    
                    <div className="absolute bottom-0 left-0 right-0 bg-black bg-opacity-50 text-white p-1 text-xs flex justify-between items-center">
                      <span>
                        {media.type === 'photo' ? (
                          <ImageIcon size={12} className="inline mr-1" />
                        ) : (
                          <Film size={12} className="inline mr-1" />
                        )}
                        {media.type === 'photo' ? 'Foto' : 'Video'}
                      </span>
                      
                      {!media.is_primary && (
                        <button
                          type="button"
                          onClick={() => setPrimaryMedia(index)}
                          className="text-xs hover:text-primary"
                          title="Jadikan Utama"
                        >
                          Jadikan Utama
                        </button>
                      )}
                      
                      {media.is_primary && (
                        <span className="text-xs text-primary">Utama</span>
                      )}
                    </div>
                    
                    {media.uploading && (
                      <div className="absolute inset-0 bg-black bg-opacity-50 flex items-center justify-center">
                        <div className="animate-spin rounded-full h-6 w-6 border-b-2 border-white"></div>
                      </div>
                    )}
                    
                    {media.error && (
                      <div className="absolute inset-0 bg-red-500 bg-opacity-50 flex items-center justify-center">
                        <div className="text-white text-xs p-2 text-center">
                          {media.error}
                        </div>
                      </div>
                    )}
                  </div>
                ))}
              </div>
            </div>
          )}
        </div>

        {/* Submit Buttons */}
        <div className="flex justify-between">
          <button
            type="button"
            onClick={() => navigate(-1)}
            className="px-4 py-2 border border-neutral-300 rounded-lg text-neutral-700 hover:bg-neutral-50 flex items-center"
          >
            <ArrowLeft size={18} className="mr-2" />
            Kembali
          </button>
          
          <button
            type="submit"
            disabled={isSubmitting || isUploading}
            className="px-6 py-2 bg-primary text-white rounded-lg hover:bg-primary/90 flex items-center disabled:opacity-50 disabled:cursor-not-allowed"
          >
            {(isSubmitting || isUploading) ? (
              <>
                <div className="animate-spin rounded-full h-4 w-4 border-b-2 border-white mr-2"></div>
                {isUploading ? 'Mengunggah Media...' : 'Menyimpan...'}
              </>
            ) : (
              <>
                <Save size={18} className="mr-2" />
                {isEdit ? 'Perbarui Properti' : 'Simpan Properti'}
              </>
            )}
          </button>
        </div>
      </form>
    </div>
  );
};

export default ListingForm;