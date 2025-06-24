import React from 'react';
import { Link } from 'react-router-dom';
import { Listing } from '../../types/listings';
import { Home, Building, Store, MapPin, Bed, Bath, Square } from 'lucide-react';

interface ListingCardProps {
  listing: Listing;
}

const ListingCard: React.FC<ListingCardProps> = ({ listing }) => {
  const formatPrice = (price: number): string => {
    if (price >= 1000000000) {
      return `Rp ${(price / 1000000000).toFixed(1)} Miliar`;
    } else if (price >= 1000000) {
      return `Rp ${(price / 1000000).toFixed(0)} Juta`;
    } else {
      return `Rp ${price.toLocaleString('id-ID')}`;
    }
  };

  const getPropertyTypeIcon = () => {
    switch (listing.property_type) {
      case 'rumah':
        return <Home size={16} className="mr-1" />;
      case 'apartemen':
        return <Building size={16} className="mr-1" />;
      case 'ruko':
        return <Store size={16} className="mr-1" />;
      case 'tanah':
        return <MapPin size={16} className="mr-1" />;
      default:
        return <Home size={16} className="mr-1" />;
    }
  };

  const getStatusBadge = () => {
    switch (listing.status) {
      case 'tersedia':
        return (
          <span className="absolute top-2 left-2 bg-green-500 text-white text-xs font-medium px-2 py-1 rounded-md">
            Tersedia
          </span>
        );
      case 'terjual':
        return (
          <span className="absolute top-2 left-2 bg-red-500 text-white text-xs font-medium px-2 py-1 rounded-md">
            Terjual
          </span>
        );
      case 'disewa':
        return (
          <span className="absolute top-2 left-2 bg-blue-500 text-white text-xs font-medium px-2 py-1 rounded-md">
            Disewa
          </span>
        );
      default:
        return null;
    }
  };

  // Find primary image or use the first one
  const primaryMedia = listing.media?.find(m => m.is_primary) || listing.media?.[0];
  const imageUrl = primaryMedia?.media_url || 'https://via.placeholder.com/300x200?text=Tidak+ada+foto';

  return (
    <Link to={`/listings/${listing.id}`} className="block">
      <div className="bg-white rounded-lg shadow-md overflow-hidden hover:shadow-lg transition-shadow">
        {/* Image */}
        <div className="relative h-48">
          <img 
            src={imageUrl} 
            alt={listing.title} 
            className="w-full h-full object-cover"
          />
          {getStatusBadge()}
        </div>
        
        {/* Content */}
        <div className="p-4">
          <h3 className="font-semibold text-lg mb-2 line-clamp-1">{listing.title}</h3>
          
          <div className="text-primary font-bold text-xl mb-2">
            {formatPrice(listing.price)}
          </div>
          
          <div className="flex items-center text-neutral-600 text-sm mb-3">
            <MapPin size={16} className="mr-1 flex-shrink-0" />
            <span className="truncate">{listing.location}</span>
          </div>
          
          <div className="flex items-center text-neutral-600 text-sm mb-3">
            {getPropertyTypeIcon()}
            <span className="capitalize">
              {listing.property_type}
            </span>
          </div>
          
          <div className="flex justify-between text-neutral-700 border-t border-neutral-200 pt-3">
            {listing.property_type !== 'tanah' && (
              <>
                {listing.bedrooms !== null && listing.bedrooms !== undefined && (
                  <div className="flex items-center">
                    <Bed size={16} className="mr-1" />
                    <span className="text-sm">{listing.bedrooms}</span>
                  </div>
                )}
                
                {listing.bathrooms !== null && listing.bathrooms !== undefined && (
                  <div className="flex items-center">
                    <Bath size={16} className="mr-1" />
                    <span className="text-sm">{listing.bathrooms}</span>
                  </div>
                )}
              </>
            )}
            
            <div className="flex items-center">
              <Square size={16} className="mr-1" />
              <span className="text-sm">{listing.square_meters} m²</span>
            </div>
          </div>
        </div>
      </div>
    </Link>
  );
};

export default ListingCard;