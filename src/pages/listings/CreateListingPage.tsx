import React from 'react';
import { Helmet } from 'react-helmet-async';
import ListingForm from '../../components/listings/ListingForm';

const CreateListingPage: React.FC = () => {
  return (
    <div className="container mx-auto px-4 py-8">
      <Helmet>
        <title>Tambah Properti Baru | Real Estate Management</title>
        <meta name="description" content="Tambahkan properti baru ke dalam sistem" />
      </Helmet>
      
      <div className="mb-6">
        <h1 className="text-2xl font-bold text-neutral-900 mb-2">Tambah Properti Baru</h1>
        <p className="text-neutral-600">
          Isi semua informasi yang diperlukan untuk menambahkan properti baru
        </p>
      </div>
      
      <ListingForm />
    </div>
  );
};

export default CreateListingPage;