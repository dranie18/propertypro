import React, { useState } from 'react';
import { ListingFilter as ListingFilterType } from '../../types/listings';
import { Filter, Search, X } from 'lucide-react';

interface ListingFilterProps {
  onFilterChange: (filters: ListingFilterType) => void;
  initialFilters?: ListingFilterType;
}

const ListingFilter: React.FC<ListingFilterProps> = ({ 
  onFilterChange,
  initialFilters = {}
}) => {
  const [filters, setFilters] = useState<ListingFilterType>(initialFilters);
  const [isExpanded, setIsExpanded] = useState(false);
  const [searchTerm, setSearchTerm] = useState(initialFilters.search_term || '');

  const handleInputChange = (e: React.ChangeEvent<HTMLInputElement | HTMLSelectElement>) => {
    const { name, value, type } = e.target;
    
    // Handle numeric inputs
    if (type === 'number') {
      setFilters({
        ...filters,
        [name]: value ? parseInt(value) : undefined
      });
    } else {
      setFilters({
        ...filters,
        [name]: value || undefined
      });
    }
  };

  const handleSearchChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setSearchTerm(e.target.value);
  };

  const handleSearchSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    
    const newFilters = {
      ...filters,
      search_term: searchTerm || undefined
    };
    
    setFilters(newFilters);
    onFilterChange(newFilters);
  };

  const handleFilterSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    onFilterChange(filters);
  };

  const clearFilters = () => {
    const emptyFilters = {};
    setFilters(emptyFilters);
    setSearchTerm('');
    onFilterChange(emptyFilters);
  };

  return (
    <div className="bg-white rounded-lg shadow-md p-4 mb-6">
      {/* Search Bar */}
      <form onSubmit={handleSearchSubmit} className="mb-4">
        <div className="relative">
          <input
            type="text"
            placeholder="Cari properti..."
            value={searchTerm}
            onChange={handleSearchChange}
            className="w-full pl-10 pr-4 py-2 border border-neutral-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary/50"
          />
          <Search 
            size={18} 
            className="absolute left-3 top-1/2 transform -translate-y-1/2 text-neutral-500" 
          />
          <button
            type="submit"
            className="absolute right-3 top-1/2 transform -translate-y-1/2 text-primary hover:text-primary/80"
          >
            Cari
          </button>
        </div>
      </form>
      
      {/* Filter Toggle */}
      <div className="flex items-center justify-between">
        <button
          type="button"
          onClick={() => setIsExpanded(!isExpanded)}
          className="flex items-center text-neutral-700 hover:text-primary"
        >
          <Filter size={18} className="mr-2" />
          <span>Filter Lanjutan</span>
        </button>
        
        {Object.keys(filters).length > 0 && (
          <button
            type="button"
            onClick={clearFilters}
            className="text-sm text-red-600 hover:text-red-800 flex items-center"
          >
            <X size={16} className="mr-1" />
            Reset Filter
          </button>
        )}
      </div>
      
      {/* Expanded Filters */}
      {isExpanded && (
        <form onSubmit={handleFilterSubmit} className="mt-4 pt-4 border-t border-neutral-200">
          <div className="grid grid-cols-1 md:grid-cols-3 gap-4 mb-4">
            <div>
              <label htmlFor="property_type" className="block text-sm font-medium text-neutral-700 mb-1">
                Tipe Properti
              </label>
              <select
                id="property_type"
                name="property_type"
                value={filters.property_type || ''}
                onChange={handleInputChange}
                className="w-full px-3 py-2 border border-neutral-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary/50"
              >
                <option value="">Semua Tipe</option>
                <option value="rumah">Rumah</option>
                <option value="apartemen">Apartemen</option>
                <option value="ruko">Ruko</option>
                <option value="tanah">Tanah</option>
              </select>
            </div>
            
            <div>
              <label htmlFor="status" className="block text-sm font-medium text-neutral-700 mb-1">
                Status
              </label>
              <select
                id="status"
                name="status"
                value={filters.status || ''}
                onChange={handleInputChange}
                className="w-full px-3 py-2 border border-neutral-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary/50"
              >
                <option value="">Semua Status</option>
                <option value="tersedia">Tersedia</option>
                <option value="terjual">Terjual</option>
                <option value="disewa">Disewa</option>
              </select>
            </div>
            
            <div>
              <label htmlFor="min_bedrooms" className="block text-sm font-medium text-neutral-700 mb-1">
                Minimal Kamar Tidur
              </label>
              <input
                type="number"
                id="min_bedrooms"
                name="min_bedrooms"
                value={filters.min_bedrooms || ''}
                onChange={handleInputChange}
                className="w-full px-3 py-2 border border-neutral-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary/50"
                placeholder="Contoh: 2"
                min="0"
              />
            </div>
          </div>
          
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4 mb-4">
            <div>
              <label className="block text-sm font-medium text-neutral-700 mb-1">
                Rentang Harga
              </label>
              <div className="grid grid-cols-2 gap-2">
                <input
                  type="number"
                  id="min_price"
                  name="min_price"
                  value={filters.min_price || ''}
                  onChange={handleInputChange}
                  className="w-full px-3 py-2 border border-neutral-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary/50"
                  placeholder="Min (Rp)"
                  min="0"
                />
                <input
                  type="number"
                  id="max_price"
                  name="max_price"
                  value={filters.max_price || ''}
                  onChange={handleInputChange}
                  className="w-full px-3 py-2 border border-neutral-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary/50"
                  placeholder="Max (Rp)"
                  min="0"
                />
              </div>
            </div>
            
            <div>
              <label className="block text-sm font-medium text-neutral-700 mb-1">
                Luas Bangunan (m²)
              </label>
              <div className="grid grid-cols-2 gap-2">
                <input
                  type="number"
                  id="min_square_meters"
                  name="min_square_meters"
                  value={filters.min_square_meters || ''}
                  onChange={handleInputChange}
                  className="w-full px-3 py-2 border border-neutral-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary/50"
                  placeholder="Min"
                  min="0"
                />
                <input
                  type="number"
                  id="max_square_meters"
                  name="max_square_meters"
                  value={filters.max_square_meters || ''}
                  onChange={handleInputChange}
                  className="w-full px-3 py-2 border border-neutral-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary/50"
                  placeholder="Max"
                  min="0"
                />
              </div>
            </div>
          </div>
          
          <div className="flex justify-end">
            <button
              type="submit"
              className="px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90"
            >
              Terapkan Filter
            </button>
          </div>
        </form>
      )}
    </div>
  );
};

export default ListingFilter;