import React, { useState, useEffect } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { Helmet } from 'react-helmet-async';
import { listingService } from '../../services/listingService';
import { Listing } from '../../types/listings';
import ListingDetail from '../../components/listings/ListingDetail';
import DeleteConfirmationModal from '../../components/listings/DeleteConfirmationModal';
import { useNotification } from '../../contexts/NotificationContext';
import { AlertCircle } from 'lucide-react';

const ListingDetailPage: React.FC = () => {
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();
  const { showSuccess, showError } = useNotification();
  
  const [listing, setListing] = useState<Listing | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [showDeleteModal, setShowDeleteModal] = useState(false);
  const [isDeleting, setIsDeleting] = useState(false);

  useEffect(() => {
    if (id) {
      fetchListing(id);
    }
  }, [id]);

  const fetchListing = async (listingId: string) => {
    setLoading(true);
    setError(null);
    
    try {
      const data = await listingService.getListingById(listingId);
      setListing(data);
    } catch (error: any) {
      console.error('Error fetching listing:', error);
      setError('Gagal memuat data properti. Silakan coba lagi nanti.');
      showError('Error', 'Gagal memuat data properti. Silakan coba lagi nanti.');
    } finally {
      setLoading(false);
    }
  };

  const handleEdit = () => {
    navigate(`/listings/edit/${id}`);
  };

  const handleDelete = async () => {
    if (!id) return;
    
    setIsDeleting(true);
    
    try {
      await listingService.deleteListing(id);
      showSuccess('Berhasil', 'Properti berhasil dihapus');
      navigate('/listings');
    } catch (error: any) {
      console.error('Error deleting listing:', error);
      showError('Gagal Menghapus', 'Terjadi kesalahan saat menghapus properti. Silakan coba lagi.');
    } finally {
      setIsDeleting(false);
      setShowDeleteModal(false);
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

  if (error || !listing) {
    return (
      <div className="container mx-auto px-4 py-8">
        <div className="bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded-lg flex items-start">
          <AlertCircle size={24} className="mr-3 flex-shrink-0" />
          <div>
            <p className="font-medium">Terjadi kesalahan</p>
            <p>{error || 'Properti tidak ditemukan'}</p>
            <button
              onClick={() => navigate('/listings')}
              className="mt-2 text-red-700 hover:text-red-900 underline"
            >
              Kembali ke daftar properti
            </button>
          </div>
        </div>
      </div>
    );
  }

  return (
    <div className="container mx-auto px-4 py-8">
      <Helmet>
        <title>{listing.title} | Real Estate Management</title>
        <meta name="description" content={listing.description.substring(0, 160)} />
      </Helmet>
      
      <ListingDetail 
        listing={listing}
        onEdit={handleEdit}
        onDelete={() => setShowDeleteModal(true)}
      />
      
      <DeleteConfirmationModal 
        isOpen={showDeleteModal}
        onClose={() => setShowDeleteModal(false)}
        onConfirm={handleDelete}
        title={listing.title}
        isDeleting={isDeleting}
      />
    </div>
  );
};

export default ListingDetailPage;