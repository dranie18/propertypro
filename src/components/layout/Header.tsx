import React, { useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { Menu, X, User, LogOut, Home, Plus, List } from 'lucide-react';
import { useAuth } from '../../contexts/AuthContext';

const Header: React.FC = () => {
  const [isMenuOpen, setIsMenuOpen] = useState(false);
  const { isAuthenticated, user, signOut } = useAuth();
  const navigate = useNavigate();

  const handleLogout = async () => {
    try {
      await signOut();
      navigate('/');
    } catch (error) {
      console.error('Logout failed:', error);
    }
  };

  return (
    <header className="bg-white shadow-md">
      <div className="container mx-auto px-4">
        <div className="flex items-center justify-between h-16">
          {/* Logo */}
          <Link to="/" className="flex items-center">
            <Home className="h-8 w-8 text-primary" />
            <span className="ml-2 text-xl font-bold text-neutral-900">
              Real<span className="text-primary">Estate</span>
            </span>
          </Link>

          {/* Desktop Navigation */}
          <nav className="hidden md:flex items-center space-x-6">
            <Link to="/" className="text-neutral-700 hover:text-primary">
              Beranda
            </Link>
            <Link to="/listings" className="text-neutral-700 hover:text-primary">
              Properti
            </Link>
            {isAuthenticated && (
              <Link to="/my-listings" className="text-neutral-700 hover:text-primary">
                Properti Saya
              </Link>
            )}
          </nav>

          {/* Auth Buttons / User Menu */}
          <div className="hidden md:flex items-center space-x-4">
            {isAuthenticated ? (
              <div className="relative group">
                <button className="flex items-center space-x-2 text-neutral-700 hover:text-primary">
                  <User className="h-5 w-5" />
                  <span>{user?.email}</span>
                </button>
                
                <div className="absolute right-0 mt-2 w-48 bg-white rounded-md shadow-lg py-1 z-10 hidden group-hover:block">
                  <Link
                    to="/my-listings"
                    className="block px-4 py-2 text-sm text-neutral-700 hover:bg-neutral-100"
                  >
                    Properti Saya
                  </Link>
                  <Link
                    to="/listings/create"
                    className="block px-4 py-2 text-sm text-neutral-700 hover:bg-neutral-100"
                  >
                    Tambah Properti
                  </Link>
                  <button
                    onClick={handleLogout}
                    className="block w-full text-left px-4 py-2 text-sm text-red-600 hover:bg-neutral-100"
                  >
                    Keluar
                  </button>
                </div>
              </div>
            ) : (
              <>
                <Link
                  to="/login"
                  className="text-neutral-700 hover:text-primary"
                >
                  Masuk
                </Link>
                <Link
                  to="/register"
                  className="bg-primary text-white px-4 py-2 rounded-lg hover:bg-primary/90"
                >
                  Daftar
                </Link>
              </>
            )}
          </div>

          {/* Mobile Menu Button */}
          <button
            className="md:hidden text-neutral-700"
            onClick={() => setIsMenuOpen(!isMenuOpen)}
          >
            {isMenuOpen ? <X className="h-6 w-6" /> : <Menu className="h-6 w-6" />}
          </button>
        </div>
      </div>

      {/* Mobile Menu */}
      {isMenuOpen && (
        <div className="md:hidden bg-white border-t border-neutral-200 py-2">
          <div className="container mx-auto px-4 space-y-2">
            <Link
              to="/"
              className="block py-2 text-neutral-700 hover:text-primary"
              onClick={() => setIsMenuOpen(false)}
            >
              Beranda
            </Link>
            <Link
              to="/listings"
              className="block py-2 text-neutral-700 hover:text-primary"
              onClick={() => setIsMenuOpen(false)}
            >
              Properti
            </Link>
            
            {isAuthenticated ? (
              <>
                <Link
                  to="/my-listings"
                  className="block py-2 text-neutral-700 hover:text-primary"
                  onClick={() => setIsMenuOpen(false)}
                >
                  <List className="h-5 w-5 inline mr-2" />
                  Properti Saya
                </Link>
                <Link
                  to="/listings/create"
                  className="block py-2 text-neutral-700 hover:text-primary"
                  onClick={() => setIsMenuOpen(false)}
                >
                  <Plus className="h-5 w-5 inline mr-2" />
                  Tambah Properti
                </Link>
                <button
                  onClick={() => {
                    handleLogout();
                    setIsMenuOpen(false);
                  }}
                  className="block w-full text-left py-2 text-red-600 hover:text-red-800"
                >
                  <LogOut className="h-5 w-5 inline mr-2" />
                  Keluar
                </button>
              </>
            ) : (
              <div className="pt-2 border-t border-neutral-200 mt-2 space-y-2">
                <Link
                  to="/login"
                  className="block py-2 text-neutral-700 hover:text-primary"
                  onClick={() => setIsMenuOpen(false)}
                >
                  Masuk
                </Link>
                <Link
                  to="/register"
                  className="block py-2 bg-primary text-white px-4 rounded-lg hover:bg-primary/90"
                  onClick={() => setIsMenuOpen(false)}
                >
                  Daftar
                </Link>
              </div>
            )}
          </div>
        </div>
      )}
    </header>
  );
};

export default Header;