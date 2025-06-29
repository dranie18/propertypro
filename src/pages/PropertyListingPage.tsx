import React, { useState, useEffect } from 'react';
import { useLocation, useParams } from 'react-router-dom';
import Layout from '../components/layout/Layout';
import PropertyCard from '../components/common/PropertyCard';
import SearchBox from '../components/common/SearchBox';
import { Property } from '../types';
import { premiumService } from '../services/premiumService';
import { GridIcon, List, SortAsc } from 'lucide-react';
import { Helmet } from 'react-helmet-async';
import { listingService } from '../services/listingService';
import { useToast } from '../contexts/ToastContext';

const PropertyListingPage: React.FC = () => {
  const location = useLocation();
  const params = useParams();
  const { showError } = useToast();
  const queryParams = new URLSearchParams(location.search);
  
  const purpose = params.purpose || queryParams.get('purpose') || 'jual';
  const propertyType = queryParams.get('type');
  const province = queryParams.get('province');
  const city = queryParams.get('city');
  const district = queryParams.get('district');
  
  const [properties, setProperties] = useState<Property[]>([]);
  const [viewMode, setViewMode] = useState<'grid' | 'list'>('grid');
  const [sortBy, setSortBy] = useState<'newest' | 'price_asc' | 'price_desc' | 'premium'>('premium');
  const [isLoading, setIsLoading] = useState(true);
  const [totalCount, setTotalCount] = useState(0);
  const [currentPage, setCurrentPage] = useState(1);
  const pageSize = 12;
  
  useEffect(() => {
    fetchProperties();
  }, [purpose, propertyType, province, city, district, sortBy, currentPage]);
  
  const fetchProperties = async () => {
    setIsLoading(true);
    try {
      // Prepare filters
      const filters: any = {
        purpose,
        sortBy,
        status: 'active'
      };
      
      if (propertyType) {
        filters.type = propertyType;
      }
      
      if (province) {
        filters.location = { province };
      }
      
      if (city) {
        filters.location = { ...filters.location, city };
      }
      
      if (district) {
        filters.location = { ...filters.location, district };
      }
      
      // Fetch properties
      const { data, count } = await listingService.getAllListings(
        filters,
        currentPage,
        pageSize
      );
      
      setProperties(data);
      setTotalCount(count);
    } catch (error) {
      console.error('Error fetching properties:', error);
      showError('Error', 'Failed to load properties. Please try again.');
    } finally {
      setIsLoading(false);
    }
  };
  
  const pageTitle = `Properti ${purpose === 'jual' ? 'Dijual' : 'Disewa'}${propertyType ? ` - ${propertyType}` : ''}`;
  
  return (
    <Layout>
      <Helmet>
        <title>{`${pageTitle} | Properti Pro`}</title>
        <meta 
          name="description" 
          content={`Temukan properti ${purpose === 'jual' ? 'dijual' : 'disewa'} di Indonesia. Pilihan terlengkap rumah, apartemen, ruko, dan properti lainnya dengan harga terbaik.`}
        />
        <meta name="keywords" content={`properti ${purpose}, ${propertyType || 'rumah, apartemen'}, ${city || 'indonesia'}, jual beli properti, sewa properti`} />
        <link rel="canonical" href={`https://propertipro.id/${purpose}`} />
      </Helmet>
      
      <div className="bg-neutral-100 py-8">
        <div className="container mx-auto px-4">
          <div className="mb-8">
            <h1 className="font-heading font-bold text-2xl md:text-3xl text-accent mb-4">
              {pageTitle}
            </h1>
            
            <div className="bg-white rounded-lg shadow-md p-4 mb-6">
              <SearchBox variant="compact" />
            </div>
            
            <div className="flex flex-col md:flex-row md:items-center justify-between bg-white p-4 rounded-lg shadow-sm">
              <p className="text-neutral-700 mb-4 md:mb-0">
                Menampilkan <span className="font-semibold">{properties.length}</span> dari <span className="font-semibold">{totalCount}</span> properti
              </p>
              
              <div className="flex flex-col sm:flex-row gap-4">
                <div className="flex items-center">
                  <span className="text-sm text-neutral-600 mr-2">Tampilan:</span>
                  <div className="flex border rounded overflow-hidden">
                    <button 
                      className={`p-2 ${viewMode === 'grid' ? 'bg-primary text-white' : 'bg-white text-neutral-700'}`}
                      onClick={() => setViewMode('grid')}
                      aria-label="Tampilan Grid"
                    >
                      <GridIcon size={16} />
                    </button>
                    <button 
                      className={`p-2 ${viewMode === 'list' ? 'bg-primary text-white' : 'bg-white text-neutral-700'}`}
                      onClick={() => setViewMode('list')}
                      aria-label="Tampilan List"
                    >
                      <List size={16} />
                    </button>
                  </div>
                </div>
                
                <div className="flex items-center">
                  <span className="text-sm text-neutral-600 mr-2">Urutkan:</span>
                  <div className="relative">
                    <div className="flex items-center border rounded p-2">
                      <SortAsc size={16} className="mr-2 text-neutral-500" />
                      <select
                        className="bg-transparent appearance-none outline-none pr-8"
                        value={sortBy}
                        onChange={(e) => setSortBy(e.target.value as any)}
                      >
                        <option value="premium">Premium & Terbaru</option>
                        <option value="newest">Terbaru</option>
                        <option value="price_asc">Harga: Rendah ke Tinggi</option>
                        <option value="price_desc">Harga: Tinggi ke Rendah</option>
                      </select>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
          
          {isLoading ? (
            <div className="flex justify-center py-12">
              <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary"></div>
            </div>
          ) : properties.length > 0 ? (
            <div className={`
              ${viewMode === 'grid' 
                ? 'grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6' 
                : 'flex flex-col space-y-4'
              }
            `}>
              {properties.map(property => (
                <PropertyCard key={property.id} property={property} />
              ))}
            </div>
          ) : (
            <div className="bg-white rounded-lg shadow-md p-8 text-center">
              <h3 className="font-heading font-semibold text-xl mb-2">
                Tidak ada properti yang ditemukan
              </h3>
              <p className="text-neutral-600 mb-4">
                Coba ubah filter pencarian Anda untuk melihat lebih banyak properti
              </p>
            </div>
          )}
          
          {/* Pagination */}
          {totalCount > pageSize && (
            <div className="mt-8 flex justify-center">
              <div className="flex items-center space-x-2">
                <button
                  onClick={() => setCurrentPage(prev => Math.max(prev - 1, 1))}
                  disabled={currentPage === 1}
                  className="px-4 py-2 border rounded-lg disabled:opacity-50"
                >
                  Prev
                </button>
                
                <div className="text-neutral-700">
                  Page {currentPage} of {Math.ceil(totalCount / pageSize)}
                </div>
                
                <button
                  onClick={() => setCurrentPage(prev => prev + 1)}
                  disabled={currentPage >= Math.ceil(totalCount / pageSize)}
                  className="px-4 py-2 border rounded-lg disabled:opacity-50"
                >
                  Next
                </button>
              </div>
            </div>
          )}
        </div>
      </div>
    </Layout>
  );
};

export default PropertyListingPage;