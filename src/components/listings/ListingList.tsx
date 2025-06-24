import React from 'react';
import { Listing } from '../../types/listings';
import ListingCard from './ListingCard';
import { Home } from 'lucide-react';

interface ListingListProps {
  listings: Listing[];
  loading: boolean;
  error?: string;
}

const ListingList: React.FC<ListingListProps> = ({ 
  listings, 
  loading, 
  error 
}) => {
  if (loading) {
    return (
      <div className="flex justify-center items-center py-12">
        <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary"></div>
      </div>
    );
  }

  if (error) {
    return (
      <div className="bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded-lg">
        <p className="font-medium">Error:</p>
        <p>{error}</p>
      </div>
    );
  }

  if (listings.length === 0) {
    return (
      <div className="bg-white rounded-lg shadow-md p-8 text-center">
        <div className="w-16 h-16 bg-neutral-100 rounded-full flex items-center justify-center mx-auto mb-4">
          <Home size={32} className="text-neutral-400" />
        </div>
        <h3 className="text-lg font-semibold text-neutral-900 mb-2">
          Tidak ada properti ditemukan
        </h3>
        <p className="text-neutral-600">
          Coba ubah filter pencarian Anda atau tambahkan properti baru
        </p>
      </div>
    );
  }

  return (
    <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
      {listings.map(listing => (
        <ListingCard key={listing.id} listing={listing} />
      ))}
    </div>
  );
};

export default ListingList;