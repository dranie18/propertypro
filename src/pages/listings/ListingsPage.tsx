import React, { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import { Helmet } from 'react-helmet-async';
import { Plus } from 'lucide-react';
import { listingService } from '../../services/listingService';
import { Listing, ListingFilter as FilterType } from '../../types/listings';
import ListingFilter from '../../components/listings/ListingFilter';
import ListingList from '../../components/listings/ListingList';
import Pagination from '../../components/listings/Pagination';
import { useNotification } from '../../contexts/NotificationContext';

const ListingsPage: React.FC = () => {
  const { showError } = useNotification();
  const [listings, setListings] = useState<Listing[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [filters, setFilters] = useState<FilterType>({});
  const [currentPage, setCurrentPage] = useState(1);
  const [totalPages, setTotalPages] = useState(1);
  const [totalCount, setTotalCount] = useState(0);
  const limit = 9; // Items per page

  useEffect(() => {
    fetchListings();
  }, [filters, currentPage]);

  const fetchListings = async () => {
    setLoading(true);
    setError(null);
    
    try {
      const response = await listingService.getListings(filters, {
        page: currentPage,
        limit
      });
      
      setListings(response.data);
      setTotalPages(response.totalPages);
      setTotalCount(response.count);
    } catch (error: any) {
      console.error('Error fetching listings:', error);
      setError('Gagal memuat data properti. Silakan coba lagi nanti.');
      showError('Error', 'Gagal memuat data properti. Silakan coba lagi nanti.');
    } finally {
      setLoading(false);
    }
  };

  const handleFilterChange = (newFilters: FilterType) => {
    setFilters(newFilters);
    setCurrentPage(1); // Reset to first page when filters change
  };

  const handlePageChange = (page: number) => {
    setCurrentPage(page);
    window.scrollTo({ top: 0, behavior: 'smooth' });
  };

  return (
    <div className="container mx-auto px-4 py-8">
      <Helmet>
        <title>Daftar Properti | Real Estate Management</title>
        <meta name="description" content="Jelajahi daftar properti yang tersedia untuk dijual atau disewa" />
      </Helmet>
      
      <div className="flex flex-col md:flex-row md:items-center justify-between mb-6">
        <div>
          <h1 className="text-2xl font-bold text-neutral-900 mb-2">Daftar Properti</h1>
          <p className="text-neutral-600">
            Jelajahi properti yang tersedia untuk dijual atau disewa
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
      
      <ListingFilter 
        onFilterChange={handleFilterChange}
        initialFilters={filters}
      />
      
      {!loading && totalCount > 0 && (
        <div className="mb-4 text-neutral-600">
          Menampilkan {listings.length} dari {totalCount} properti
        </div>
      )}
      
      <ListingList 
        listings={listings}
        loading={loading}
        error={error || undefined}
      />
      
      <Pagination 
        currentPage={currentPage}
        totalPages={totalPages}
        onPageChange={handlePageChange}
      />
    </div>
  );
};

export default ListingsPage;