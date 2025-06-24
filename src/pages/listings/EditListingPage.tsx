import React, { useState, useEffect } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { Helmet } from 'react-helmet-async';
import { listingService } from '../../services/listingService';
import { ListingFormData } from '../../types/listings';
import ListingForm from '../../components/listings/ListingForm';
import { useNotification } from '../../contexts/NotificationContext';
import { AlertCircle } from 'lucide-react';

const EditListingPage: React.FC = () => {
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();
  const { showError } = useNotification();
  
  const [formData, setFormData] = useState<ListingFormData | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    if (id) {
      fetchListing(id);
    }
  }, [id]);

  const fetchListing = async (listingId: string) => {
    setLoading(true);
    setError(null);
    
    try {
      const listing = await listingService.getListingById(listingId);
      
      // Extract form data from listing
      const formData: ListingFormData = {
        title: listing.title,
        description: listing.description,
        price: listing.price,
        location: listing.location,
        property_type: listing.property_type,
        status: listing.status,
        square_meters: listing.square_meters,
        bedrooms: listing.bedrooms,
        bathrooms: listing.bathrooms
      };
      
      setFormData(formData);
    } catch (error: any) {
      console.error('Error fetching listing:', error);
      setError('Gagal memuat data properti. Silakan coba lagi nanti.');
      showError('Error', 'Gagal memuat data properti. Silakan coba lagi nanti.');
    } finally {
      setLoading(false);
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

  if (error || !formData) {
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
        <title>Edit Properti | Real Estate Management</title>
        <meta name="description" content="Edit informasi properti" />
      </Helmet>
      
      <div className="mb-6">
        <h1 className="text-2xl font-bold text-neutral-900 mb-2">Edit Properti</h1>
        <p className="text-neutral-600">
          Perbarui informasi properti Anda
        </p>
      </div>
      
      <ListingForm 
        initialData={formData}
        listingId={id}
        isEdit={true}
      />
    </div>
  );
};

export default EditListingPage;