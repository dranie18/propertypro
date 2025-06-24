import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { Listing } from '../../types/listings';
import { 
  Home, 
  Building, 
  Store, 
  MapPin, 
  Bed, 
  Bath, 
  Square, 
  Calendar, 
  Edit, 
  Trash2, 
  ChevronLeft, 
  ChevronRight,
  Play
} from 'lucide-react';
import { useAuth } from '../../contexts/AuthContext';

interface ListingDetailProps {
  listing: Listing;
  onEdit: () => void;
  onDelete: () => void;
}

const ListingDetail: React.FC<ListingDetailProps> = ({ 
  listing, 
  onEdit, 
  onDelete 
}) => {
  const navigate = useNavigate();
  const { user } = useAuth();
  const [activeMediaIndex, setActiveMediaIndex] = useState(0);
  
  const formatPrice = (price: number): string => {
    if (price >= 1000000000) {
      return `Rp ${(price / 1000000000).toFixed(1)} Miliar`;
    } else if (price >= 1000000) {
      return `Rp ${(price / 1000000).toFixed(0)} Juta`;
    } else {
      return `Rp ${price.toLocaleString('id-ID')}`;
    }
  };

  const formatDate = (dateString: string): string => {
    const date = new Date(dateString);
    return date.toLocaleDateString('id-ID', {
      day: 'numeric',
      month: 'long',
      year: 'numeric'
    });
  };

  const getPropertyTypeIcon = () => {
    switch (listing.property_type) {
      case 'rumah':
        return <Home size={20} className="mr-2" />;
      case 'apartemen':
        return <Building size={20} className="mr-2" />;
      case 'ruko':
        return <Store size={20} className="mr-2" />;
      case 'tanah':
        return <MapPin size={20} className="mr-2" />;
      default:
        return <Home size={20} className="mr-2" />;
    }
  };

  const getStatusBadge = () => {
    switch (listing.status) {
      case 'tersedia':
        return (
          <span className="inline-flex items-center px-3 py-1 rounded-full text-sm font-medium bg-green-100 text-green-800">
            Tersedia
          </span>
        );
      case 'terjual':
        return (
          <span className="inline-flex items-center px-3 py-1 rounded-full text-sm font-medium bg-red-100 text-red-800">
            Terjual
          </span>
        );
      case 'disewa':
        return (
          <span className="inline-flex items-center px-3 py-1 rounded-full text-sm font-medium bg-blue-100 text-blue-800">
            Disewa
          </span>
        );
      default:
        return null;
    }
  };

  const isOwner = user?.id === listing.user_id;
  const media = listing.media || [];
  const activeMedia = media[activeMediaIndex];
  const isVideo = activeMedia?.media_type === 'video';

  const nextMedia = () => {
    setActiveMediaIndex((prev) => (prev + 1) % media.length);
  };

  const prevMedia = () => {
    setActiveMediaIndex((prev) => (prev - 1 + media.length) % media.length);
  };

  const selectMedia = (index: number) => {
    setActiveMediaIndex(index);
  };

  return (
    <div className="bg-white rounded-lg shadow-md overflow-hidden">
      {/* Media Gallery */}
      <div className="relative">
        {media.length > 0 ? (
          <div className="relative h-96">
            {isVideo ? (
              <video 
                src={activeMedia.media_url} 
                controls 
                className="w-full h-full object-contain bg-neutral-900"
              />
            ) : (
              <img 
                src={activeMedia.media_url} 
                alt={listing.title} 
                className="w-full h-full object-contain bg-neutral-100"
              />
            )}
            
            {/* Navigation arrows */}
            {media.length > 1 && (
              <>
                <button 
                  onClick={(e) => { e.preventDefault(); prevMedia(); }}
                  className="absolute left-2 top-1/2 transform -translate-y-1/2 bg-black bg-opacity-50 text-white p-2 rounded-full hover:bg-opacity-70"
                >
                  <ChevronLeft size={24} />
                </button>
                <button 
                  onClick={(e) => { e.preventDefault(); nextMedia(); }}
                  className="absolute right-2 top-1/2 transform -translate-y-1/2 bg-black bg-opacity-50 text-white p-2 rounded-full hover:bg-opacity-70"
                >
                  <ChevronRight size={24} />
                </button>
              </>
            )}
          </div>
        ) : (
          <div className="h-96 bg-neutral-200 flex items-center justify-center">
            <p className="text-neutral-500">Tidak ada foto</p>
          </div>
        )}
      </div>
      
      {/* Thumbnails */}
      {media.length > 1 && (
        <div className="p-2 bg-neutral-100 overflow-x-auto">
          <div className="flex space-x-2">
            {media.map((item, index) => (
              <button
                key={item.id}
                onClick={(e) => { e.preventDefault(); selectMedia(index); }}
                className={`w-20 h-20 flex-shrink-0 rounded overflow-hidden border-2 ${
                  index === activeMediaIndex ? 'border-primary' : 'border-transparent'
                }`}
              >
                {item.media_type === 'video' ? (
                  <div className="w-full h-full bg-neutral-800 flex items-center justify-center">
                    <Play size={24} className="text-white" />
                  </div>
                ) : (
                  <img 
                    src={item.media_url} 
                    alt={`Thumbnail ${index + 1}`} 
                    className="w-full h-full object-cover"
                  />
                )}
              </button>
            ))}
          </div>
        </div>
      )}
      
      {/* Content */}
      <div className="p-6">
        <div className="flex flex-col md:flex-row md:items-center justify-between mb-4">
          <div>
            <div className="flex items-center mb-2">
              {getStatusBadge()}
              <span className="ml-2 text-sm text-neutral-500">
                Diperbarui: {formatDate(listing.updated_at)}
              </span>
            </div>
            <h1 className="text-2xl font-bold text-neutral-900 mb-2">{listing.title}</h1>
            <div className="flex items-center text-neutral-600">
              <MapPin size={18} className="mr-1" />
              <span>{listing.location}</span>
            </div>
          </div>
          
          <div className="mt-4 md:mt-0">
            <div className="text-3xl font-bold text-primary">
              {formatPrice(listing.price)}
            </div>
          </div>
        </div>
        
        {/* Property Details */}
        <div className="grid grid-cols-2 md:grid-cols-4 gap-4 mb-6 border-t border-b border-neutral-200 py-4">
          <div className="flex flex-col items-center justify-center p-3">
            <div className="flex items-center text-neutral-700 mb-1">
              {getPropertyTypeIcon()}
              <span className="capitalize">{listing.property_type}</span>
            </div>
            <span className="text-sm text-neutral-500">Tipe Properti</span>
          </div>
          
          <div className="flex flex-col items-center justify-center p-3">
            <div className="flex items-center text-neutral-700 mb-1">
              <Square size={20} className="mr-2" />
              <span>{listing.square_meters} m²</span>
            </div>
            <span className="text-sm text-neutral-500">Luas</span>
          </div>
          
          {listing.property_type !== 'tanah' && (
            <>
              {listing.bedrooms !== null && listing.bedrooms !== undefined && (
                <div className="flex flex-col items-center justify-center p-3">
                  <div className="flex items-center text-neutral-700 mb-1">
                    <Bed size={20} className="mr-2" />
                    <span>{listing.bedrooms}</span>
                  </div>
                  <span className="text-sm text-neutral-500">Kamar Tidur</span>
                </div>
              )}
              
              {listing.bathrooms !== null && listing.bathrooms !== undefined && (
                <div className="flex flex-col items-center justify-center p-3">
                  <div className="flex items-center text-neutral-700 mb-1">
                    <Bath size={20} className="mr-2" />
                    <span>{listing.bathrooms}</span>
                  </div>
                  <span className="text-sm text-neutral-500">Kamar Mandi</span>
                </div>
              )}
            </>
          )}
          
          <div className="flex flex-col items-center justify-center p-3">
            <div className="flex items-center text-neutral-700 mb-1">
              <Calendar size={20} className="mr-2" />
              <span>{formatDate(listing.created_at)}</span>
            </div>
            <span className="text-sm text-neutral-500">Tanggal Publikasi</span>
          </div>
        </div>
        
        {/* Description */}
        <div className="mb-6">
          <h2 className="text-xl font-semibold text-neutral-900 mb-3">Deskripsi</h2>
          <div className="text-neutral-700 whitespace-pre-line">
            {listing.description}
          </div>
        </div>
        
        {/* Owner Actions */}
        {isOwner && (
          <div className="flex justify-end space-x-3 border-t border-neutral-200 pt-4">
            <button
              onClick={() => navigate(-1)}
              className="px-4 py-2 border border-neutral-300 rounded-lg text-neutral-700 hover:bg-neutral-50"
            >
              Kembali
            </button>
            <button
              onClick={onEdit}
              className="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 flex items-center"
            >
              <Edit size={18} className="mr-2" />
              Edit
            </button>
            <button
              onClick={onDelete}
              className="px-4 py-2 bg-red-600 text-white rounded-lg hover:bg-red-700 flex items-center"
            >
              <Trash2 size={18} className="mr-2" />
              Hapus
            </button>
          </div>
        )}
      </div>
    </div>
  );
};

export default ListingDetail;