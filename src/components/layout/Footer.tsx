import React from 'react';
import { Link } from 'react-router-dom';
import { Home, Mail, Phone, MapPin } from 'lucide-react';

const Footer: React.FC = () => {
  return (
    <footer className="bg-neutral-800 text-white">
      <div className="container mx-auto px-4 py-8">
        <div className="grid grid-cols-1 md:grid-cols-4 gap-8">
          <div>
            <div className="flex items-center mb-4">
              <Home className="h-8 w-8 text-primary" />
              <span className="ml-2 text-xl font-bold">
                Real<span className="text-primary">Estate</span>
              </span>
            </div>
            <p className="text-neutral-400 mb-4">
              Platform manajemen properti terpercaya untuk jual beli dan sewa properti di Indonesia.
            </p>
          </div>
          
          <div>
            <h3 className="text-lg font-semibold mb-4">Properti</h3>
            <ul className="space-y-2">
              <li>
                <Link to="/listings" className="text-neutral-400 hover:text-primary">
                  Semua Properti
                </Link>
              </li>
              <li>
                <Link to="/listings?property_type=rumah" className="text-neutral-400 hover:text-primary">
                  Rumah
                </Link>
              </li>
              <li>
                <Link to="/listings?property_type=apartemen" className="text-neutral-400 hover:text-primary">
                  Apartemen
                </Link>
              </li>
              <li>
                <Link to="/listings?property_type=ruko" className="text-neutral-400 hover:text-primary">
                  Ruko
                </Link>
              </li>
              <li>
                <Link to="/listings?property_type=tanah" className="text-neutral-400 hover:text-primary">
                  Tanah
                </Link>
              </li>
            </ul>
          </div>
          
          <div>
            <h3 className="text-lg font-semibold mb-4">Akun</h3>
            <ul className="space-y-2">
              <li>
                <Link to="/login" className="text-neutral-400 hover:text-primary">
                  Masuk
                </Link>
              </li>
              <li>
                <Link to="/register" className="text-neutral-400 hover:text-primary">
                  Daftar
                </Link>
              </li>
              <li>
                <Link to="/my-listings" className="text-neutral-400 hover:text-primary">
                  Properti Saya
                </Link>
              </li>
              <li>
                <Link to="/listings/create" className="text-neutral-400 hover:text-primary">
                  Tambah Properti
                </Link>
              </li>
            </ul>
          </div>
          
          <div>
            <h3 className="text-lg font-semibold mb-4">Kontak</h3>
            <ul className="space-y-3">
              <li className="flex items-start">
                <MapPin className="h-5 w-5 text-primary mr-2 mt-0.5" />
                <span className="text-neutral-400">
                  Jl. Sudirman No. 123, Jakarta Pusat, DKI Jakarta 10270
                </span>
              </li>
              <li className="flex items-center">
                <Phone className="h-5 w-5 text-primary mr-2" />
                <a href="tel:+6281234567890" className="text-neutral-400 hover:text-primary">
                  +62 812 3456 7890
                </a>
              </li>
              <li className="flex items-center">
                <Mail className="h-5 w-5 text-primary mr-2" />
                <a href="mailto:info@realestate.com" className="text-neutral-400 hover:text-primary">
                  info@realestate.com
                </a>
              </li>
            </ul>
          </div>
        </div>
        
        <div className="border-t border-neutral-700 mt-8 pt-6 text-center text-neutral-400 text-sm">
          <p>&copy; {new Date().getFullYear()} Real Estate Management. All rights reserved.</p>
        </div>
      </div>
    </footer>
  );
};

export default Footer;