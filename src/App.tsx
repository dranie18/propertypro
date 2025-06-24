import React from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import { HelmetProvider } from 'react-helmet-async';
import { AuthProvider } from './contexts/AuthContext';
import { NotificationProvider } from './contexts/NotificationContext';

// Pages
import HomePage from './pages/HomePage';
import ListingsPage from './pages/listings/ListingsPage';
import ListingDetailPage from './pages/listings/ListingDetailPage';
import CreateListingPage from './pages/listings/CreateListingPage';
import EditListingPage from './pages/listings/EditListingPage';
import UserListingsPage from './pages/listings/UserListingsPage';
import LoginPage from './pages/LoginPage';
import RegisterPage from './pages/RegisterPage';
import ForgotPasswordPage from './pages/ForgotPasswordPage';
import ResetPasswordPage from './pages/ResetPasswordPage';

// Components
import Layout from './components/layout/Layout';
import ProtectedRoute from './components/common/ProtectedRoute';

function App() {
  return (
    <HelmetProvider>
      <AuthProvider>
        <NotificationProvider>
          <Router>
            <Routes>
              <Route path="/" element={<Layout />}>
                <Route index element={<HomePage />} />
                <Route path="listings" element={<ListingsPage />} />
                <Route path="listings/:id" element={<ListingDetailPage />} />
                
                {/* Protected Routes */}
                <Route path="listings/create" element={
                  <ProtectedRoute>
                    <CreateListingPage />
                  </ProtectedRoute>
                } />
                <Route path="listings/edit/:id" element={
                  <ProtectedRoute>
                    <EditListingPage />
                  </ProtectedRoute>
                } />
                <Route path="my-listings" element={
                  <ProtectedRoute>
                    <UserListingsPage />
                  </ProtectedRoute>
                } />
              </Route>
              
              {/* Auth Routes */}
              <Route path="/login" element={<LoginPage />} />
              <Route path="/register" element={<RegisterPage />} />
              <Route path="/forgot-password" element={<ForgotPasswordPage />} />
              <Route path="/reset-password" element={<ResetPasswordPage />} />
            </Routes>
          </Router>
        </NotificationProvider>
      </AuthProvider>
    </HelmetProvider>
  );
}

export default App;