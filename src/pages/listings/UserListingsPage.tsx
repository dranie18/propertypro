import React, { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import { Helmet } from 'react-helmet-async';
import { Plus, Edit, Trash2, Eye, AlertCircle } from 'lucide-react';
import { listingService } from '../../services/listingService';
import { Listing } from '../../types/listings';
import DeleteConfirmationModal from '../../components/listings/DeleteConfirmationModal';
import { useNotification } from '../../contexts/NotificationContext';

const UserListingsPage: React.FC = () => {
  const { showSuccess, showError } = useNotification();
  
  const [listings, setListings] = useState<Listing[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [listingToDelete, setListingToDelete] = useState<Listing | null>(null);
  const [isDeleting, setIsDeleting] = useState(false);

  useEffect(() => {
    fetchUserListings();
  }, []);

  const fetchUserListings = async () => {
    setLoading(true);
    setError(null);
    
    try {
      const data = await listingService.getUserListings();
      setListings(data);
    } catch (error: any) {
      console.error('Error fetching user listings:', error);
      setError('Gagal memuat data properti Anda. Silakan coba lagi nanti.');
      showError('Error', 'Gagal memuat data properti Anda. Silakan coba lagi nanti.');
    } finally {
      setLoading(false);
    }
  };

  const handleDelete = async () => {
    if (!listingToDelete) return;
    
    setIsDeleting(true);
    
    try {
      await listingService.deleteListing(listingToDelete.id);
      setListings(listings.filter(listing => listing.id !== listingToDelete.id));
      showSuccess('Berhasil', 'Properti berhasil dihapus');
    } catch (error: any) {
      console.error('Error deleting listing:', error);
      showError('Gagal Menghapus', 'Terjadi kesalahan saat menghapus properti. Silakan coba lagi.');
    } finally {
      setIsDeleting(false);
      setListingToDelete(null);
    }
  };

  const formatPrice = (price: number): string => {
    if (price >= 1000000000) {
      return `Rp ${(price / 1000000000).toFixed(1)} Miliar`;
    } else if (price >= 1000000) {
      return `Rp ${(price / 1000000).toFixed(0)} Juta`;
    } else {
      return `Rp ${price.toLocaleString('id-ID')}`;
    }
  };

  const getStatusBadge = (status: string) => {
    switch (status) {
      case 'tersedia':
        return (
          <span className="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-800">
            Tersedia
          </span>
        );
      case 'terjual':
        return (
          <span className="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-red-100 text-red-800">
            Terjual
          </span>
        );
      case 'disewa':
        return (
          <span className="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-blue-100 text-blue-800">
            Disewa
          </span>
        );
      default:
        return null;
    }
  };

  if (loading) {
    return (
      <div className="container mx-auto px-4 py-8">
        <div className="flex justify-center items-center py-12">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary"></div>
        </div>
      </div>
    );
  }

  return (
    <div className="container mx-auto px-4 py-8">
      <Helmet>
        <title>Properti Saya | Real Estate Management</title>
        <meta name="description" content="Kelola daftar properti Anda" />
      </Helmet>
      
      <div className="flex flex-col md:flex-row md:items-center justify-between mb-6">
        <div>
          <h1 className="text-2xl font-bold text-neutral-900 mb-2">Properti Saya</h1>
          <p className="text-neutral-600">
            Kelola daftar properti yang Anda tambahkan
          </p>
        </div>
        
        <Link
          to="/listings/create"
          className="mt-4 md:mt-0 px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90 flex items-center justify-center"
        >
          <Plus size={18} className="mr-2" />
          Tambah Properti
        </Link>
      </div>
      
      {error && (
        <div className="bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded-lg mb-6 flex items-start">
          <AlertCircle size={24} className="mr-3 flex-shrink-0" />
          <div>
            <p className="font-medium">Terjadi kesalahan</p>
            <p>{error}</p>
          </div>
        </div>
      )}
      
      {listings.length === 0 ? (
        <div className="bg-white rounded-lg shadow-md p-8 text-center">
          <div className="w-16 h-16 bg-neutral-100 rounded-full flex items-center justify-center mx-auto mb-4">
            <Plus size={32} className="text-neutral-400" />
          </div>
          <h3 className="text-lg font-semibold text-neutral-900 mb-2">
            Belum ada properti
          </h3>
          <p className="text-neutral-600 mb-6">
            Anda belum menambahkan properti apa pun. Mulai dengan menambahkan properti pertama Anda.
          </p>
          <Link
            to="/listings/create"
            className="px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90 inline-flex items-center"
          >
            <Plus size={18} className="mr-2" />
            Tambah Properti Pertama
          </Link>
        </div>
      ) : (
        <div className="bg-white rounded-lg shadow-md overflow-hidden">
          <div className="overflow-x-auto">
            <table className="w-full">
              <thead className="bg-neutral-50 border-b border-neutral-200">
                <tr>
                  <th className="px-6 py-3 text-left text-xs font-medium text-neutral-500 uppercase tracking-wider">
                    Properti
                  </th>
                  <th className="px-6 py-3 text-left text-xs font-medium text-neutral-500 uppercase tracking-wider">
                    Harga
                  </th>
                  <th className="px-6 py-3 text-left text-xs font-medium text-neutral-500 uppercase tracking-wider">
                    Tipe
                  </th>
                  <th className="px-6 py-3 text-left text-xs font-medium text-neutral-500 uppercase tracking-wider">
                    Status
                  </th>
                  <th className="px-6 py-3 text-right text-xs font-medium text-neutral-500 uppercase tracking-wider">
                    Aksi
                  </th>
                </tr>
              </thead>
              <tbody className="divide-y divide-neutral-200">
                {listings.map(listing => {
                  // Find primary image or use the first one
                  const primaryMedia = listing.media?.find(m => m.is_primary) || listing.media?.[0];
                  const imageUrl = primaryMedia?.media_url || 'https://via.placeholder.com/50x50?text=No+Image';
                  
                  return (
                    <tr key={listing.id} className="hover:bg-neutral-50">
                      <td className="px-6 py-4 whitespace-nowrap">
                        <div className="flex items-center">
                          <div className="h-10 w-10 flex-shrink-0 mr-3">
                            <img 
                              src={imageUrl} 
                              alt={listing.title} 
                              className="h-10 w-10 rounded-md object-cover"
                            />
                          </div>
                          <div className="max-w-xs truncate">
                            <div className="text-sm font-medium text-neutral-900 truncate">
                              {listing.title}
                            </div>
                            <div className="text-sm text-neutral-500 truncate">
                              {listing.location}
                            </div>
                          </div>
                        </div>
                      </td>
                      <td className="px-6 py-4 whitespace-nowrap">
                        <div className="text-sm font-medium text-primary">
                          {formatPrice(listing.price)}
                        </div>
                      </td>
                      <td className="px-6 py-4 whitespace-nowrap">
                        <div className="text-sm text-neutral-900 capitalize">
                          {listing.property_type}
                        </div>
                      </td>
                      <td className="px-6 py-4 whitespace-nowrap">
                        {getStatusBadge(listing.status)}
                      </td>
                      <td className="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                        <div className="flex justify-end space-x-2">
                          <Link
                            to={`/listings/${listing.id}`}
                            className="text-neutral-600 hover:text-primary"
                            title="Lihat Detail"
                          >
                            <Eye size={18} />
                          </Link>
                          <Link
                            to={`/listings/edit/${listing.id}`}
                            className="text-neutral-600 hover:text-blue-600"
                            title="Edit"
                          >
                            <Edit size={18} />
                          </Link>
                          <button
                            onClick={() => setListingToDelete(listing)}
                            className="text-neutral-600 hover:text-red-600"
                            title="Hapus"
                          >
                            <Trash2 size={18} />
                          </button>
                        </div>
                      </td>
                    </tr>
                  );
                })}
              </tbody>
            </table>
          </div>
        </div>
      )}
      
      <DeleteConfirmationModal 
        isOpen={!!listingToDelete}
        onClose={() => setListingToDelete(null)}
        onConfirm={handleDelete}
        title={listingToDelete?.title || ''}
        isDeleting={isDeleting}
      />
    </div>
  );
};

export default UserListingsPage;