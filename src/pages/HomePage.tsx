import React from 'react';
import { Link } from 'react-router-dom';
import { Helmet } from 'react-helmet-async';
import { Home, Building, Store, MapPin, Search, Plus } from 'lucide-react';
import { useAuth } from '../contexts/AuthContext';

const HomePage: React.FC = () => {
  const { isAuthenticated } = useAuth();

  return (
    <div>
      <Helmet>
        <title>Real Estate Management | Jual Beli & Sewa Properti</title>
        <meta name="description" content="Platform manajemen properti terpercaya untuk jual beli dan sewa properti di Indonesia" />
      </Helmet>
      
      {/* Hero Section */}
      <section className="relative">
        <div 
          className="h-[500px] bg-cover bg-center"
          style={{ backgroundImage: 'url(https://images.pexels.com/photos/323780/pexels-photo-323780.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750)' }}
        >
          <div className="absolute inset-0 bg-black bg-opacity-50"></div>
          <div className="relative container mx-auto px-4 h-full flex flex-col justify-center">
            <div className="max-w-2xl">
              <h1 className="text-4xl md:text-5xl font-bold text-white mb-4">
                Temukan Properti Impian Anda
              </h1>
              <p className="text-xl text-white mb-8">
                Platform manajemen properti terpercaya untuk jual beli dan sewa properti di Indonesia
              </p>
              
              <div className="flex flex-col sm:flex-row gap-4">
                <Link
                  to="/listings"
                  className="bg-primary text-white px-6 py-3 rounded-lg hover:bg-primary/90 flex items-center justify-center"
                >
                  <Search className="mr-2" />
                  Cari Properti
                </Link>
                
                {isAuthenticated && (
                  <Link
                    to="/listings/create"
                    className="bg-white text-primary px-6 py-3 rounded-lg hover:bg-neutral-100 flex items-center justify-center"
                  >
                    <Plus className="mr-2" />
                    Tambah Properti
                  </Link>
                )}
              </div>
            </div>
          </div>
        </div>
      </section>
      
      {/* Property Types Section */}
      <section className="py-16">
        <div className="container mx-auto px-4">
          <div className="text-center mb-12">
            <h2 className="text-3xl font-bold text-neutral-900 mb-4">
              Jelajahi Berdasarkan Tipe Properti
            </h2>
            <p className="text-neutral-600 max-w-2xl mx-auto">
              Temukan properti yang sesuai dengan kebutuhan Anda dari berbagai pilihan tipe properti
            </p>
          </div>
          
          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
            <Link
              to="/listings?property_type=rumah"
              className="bg-white rounded-lg shadow-md p-6 hover:shadow-lg transition-shadow flex flex-col items-center text-center"
            >
              <div className="w-16 h-16 bg-primary/10 rounded-full flex items-center justify-center mb-4">
                <Home className="h-8 w-8 text-primary" />
              </div>
              <h3 className="text-xl font-semibold text-neutral-900 mb-2">Rumah</h3>
              <p className="text-neutral-600">
                Temukan rumah impian untuk keluarga Anda
              </p>
            </Link>
            
            <Link
              to="/listings?property_type=apartemen"
              className="bg-white rounded-lg shadow-md p-6 hover:shadow-lg transition-shadow flex flex-col items-center text-center"
            >
              <div className="w-16 h-16 bg-primary/10 rounded-full flex items-center justify-center mb-4">
                <Building className="h-8 w-8 text-primary" />
              </div>
              <h3 className="text-xl font-semibold text-neutral-900 mb-2">Apartemen</h3>
              <p className="text-neutral-600">
                Hunian modern dengan fasilitas lengkap
              </p>
            </Link>
            
            <Link
              to="/listings?property_type=ruko"
              className="bg-white rounded-lg shadow-md p-6 hover:shadow-lg transition-shadow flex flex-col items-center text-center"
            >
              <div className="w-16 h-16 bg-primary/10 rounded-full flex items-center justify-center mb-4">
                <Store className="h-8 w-8 text-primary" />
              </div>
              <h3 className="text-xl font-semibold text-neutral-900 mb-2">Ruko</h3>
              <p className="text-neutral-600">
                Properti komersial untuk bisnis Anda
              </p>
            </Link>
            
            <Link
              to="/listings?property_type=tanah"
              className="bg-white rounded-lg shadow-md p-6 hover:shadow-lg transition-shadow flex flex-col items-center text-center"
            >
              <div className="w-16 h-16 bg-primary/10 rounded-full flex items-center justify-center mb-4">
                <MapPin className="h-8 w-8 text-primary" />
              </div>
              <h3 className="text-xl font-semibold text-neutral-900 mb-2">Tanah</h3>
              <p className="text-neutral-600">
                Investasi tanah untuk masa depan
              </p>
            </Link>
          </div>
        </div>
      </section>
      
      {/* Features Section */}
      <section className="py-16 bg-neutral-100">
        <div className="container mx-auto px-4">
          <div className="text-center mb-12">
            <h2 className="text-3xl font-bold text-neutral-900 mb-4">
              Fitur Unggulan
            </h2>
            <p className="text-neutral-600 max-w-2xl mx-auto">
              Nikmati berbagai fitur yang memudahkan Anda dalam mengelola properti
            </p>
          </div>
          
          <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
            <div className="bg-white rounded-lg shadow-md p-6">
              <div className="w-12 h-12 bg-primary/10 rounded-full flex items-center justify-center mb-4">
                <Search className="h-6 w-6 text-primary" />
              </div>
              <h3 className="text-xl font-semibold text-neutral-900 mb-2">Pencarian Mudah</h3>
              <p className="text-neutral-600">
                Temukan properti yang sesuai dengan kebutuhan Anda dengan fitur pencarian dan filter yang lengkap.
              </p>
            </div>
            
            <div className="bg-white rounded-lg shadow-md p-6">
              <div className="w-12 h-12 bg-primary/10 rounded-full flex items-center justify-center mb-4">
                <Plus className="h-6 w-6 text-primary" />
              </div>
              <h3 className="text-xl font-semibold text-neutral-900 mb-2">Tambah Properti</h3>
              <p className="text-neutral-600">
                Tambahkan properti Anda dengan mudah dan cepat. Unggah hingga 20 foto dan 1 video untuk setiap properti.
              </p>
            </div>
            
            <div className="bg-white rounded-lg shadow-md p-6">
              <div className="w-12 h-12 bg-primary/10 rounded-full flex items-center justify-center mb-4">
                <Home className="h-6 w-6 text-primary" />
              </div>
              <h3 className="text-xl font-semibold text-neutral-900 mb-2">Kelola Properti</h3>
              <p className="text-neutral-600">
                Kelola semua properti Anda dalam satu tempat. Edit, hapus, atau perbarui status properti dengan mudah.
              </p>
            </div>
          </div>
        </div>
      </section>
      
      {/* CTA Section */}
      <section className="py-16 bg-primary">
        <div className="container mx-auto px-4 text-center">
          <h2 className="text-3xl font-bold text-white mb-4">
            Siap Untuk Memulai?
          </h2>
          <p className="text-white/90 max-w-2xl mx-auto mb-8">
            Daftar sekarang dan mulai kelola properti Anda dengan mudah dan efisien
          </p>
          
          <div className="flex flex-col sm:flex-row gap-4 justify-center">
            {isAuthenticated ? (
              <Link
                to="/listings/create"
                className="bg-white text-primary px-6 py-3 rounded-lg hover:bg-neutral-100 inline-flex items-center justify-center"
              >
                <Plus className="mr-2" />
                Tambah Properti Sekarang
              </Link>
            ) : (
              <>
                <Link
                  to="/register"
                  className="bg-white text-primary px-6 py-3 rounded-lg hover:bg-neutral-100"
                >
                  Daftar Sekarang
                </Link>
                <Link
                  to="/login"
                  className="bg-transparent text-white border border-white px-6 py-3 rounded-lg hover:bg-white/10"
                >
                  Masuk
                </Link>
              </>
            )}
          </div>
        </div>
      </section>
    </div>
  );
};

export default HomePage;