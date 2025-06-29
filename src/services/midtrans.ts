import axios from 'axios';
import { MidtransConfig, MidtransResponse, PaymentData, BillingDetails } from '../types/premium';

class MidtransService {
  private config: MidtransConfig;

  constructor() {
    this.config = {
      clientKey: import.meta.env.VITE_MIDTRANS_CLIENT_KEY || 'SB-Mid-client-demo',
      serverKey: import.meta.env.VITE_MIDTRANS_SERVER_KEY || 'SB-Mid-server-demo',
      isProduction: import.meta.env.VITE_MIDTRANS_IS_PRODUCTION === 'true',
      snapUrl: import.meta.env.VITE_MIDTRANS_IS_PRODUCTION === 'true' 
        ? 'https://app.midtrans.com/snap/snap.js'
        : 'https://app.sandbox.midtrans.com/snap/snap.js'
    };
  }

  async createTransaction(paymentData: {
    orderId: string;
    amount: number;
    billingDetails: BillingDetails;
    itemDetails: {
      id: string;
      name: string;
      price: number;
      quantity: number;
    }[];
  }): Promise<MidtransResponse> {
    try {
      // In a real implementation, this would call your backend API
      // which then calls Midtrans API with server key
      // For now, we'll use a placeholder response for development
      console.log('Creating Midtrans transaction:', paymentData);
      
      // Simulate API response
      return {
        token: 'demo-token-' + Date.now(),
        redirect_url: '#'
      };
    } catch (error) {
      console.error('Midtrans transaction creation failed:', error);
      throw error;
    }
  }

  loadSnapScript(): Promise<void> {
    return new Promise((resolve, reject) => {
      if (window.snap) {
        resolve();
        return;
      }

      const script = document.createElement('script');
      script.src = this.config.snapUrl;
      script.setAttribute('data-client-key', this.config.clientKey);
      script.onload = () => resolve();
      script.onerror = () => reject(new Error('Failed to load Midtrans Snap script'));
      document.head.appendChild(script);
    });
  }

  async openPaymentModal(token: string): Promise<any> {
    await this.loadSnapScript();
    
    return new Promise((resolve, reject) => {
      if (!window.snap) {
        reject(new Error('Midtrans Snap not loaded'));
        return;
      }

      window.snap.pay(token, {
        onSuccess: (result: any) => {
          resolve({ status: 'success', result });
        },
        onPending: (result: any) => {
          resolve({ status: 'pending', result });
        },
        onError: (result: any) => {
          reject({ status: 'error', result });
        },
        onClose: () => {
          resolve({ status: 'closed' });
        }
      });
    });
  }

  async checkTransactionStatus(orderId: string): Promise<any> {
    try {
      // In a real implementation, this would call your backend API
      // For now, we'll use a placeholder response for development
      console.log('Checking transaction status for order:', orderId);
      
      // Simulate API response
      return {
        transaction_status: 'settlement',
        payment_type: 'credit_card',
        transaction_time: new Date().toISOString()
      };
    } catch (error) {
      console.error('Failed to check transaction status:', error);
      throw error;
    }
  }
}

// Extend Window interface for Midtrans Snap
declare global {
  interface Window {
    snap: {
      pay: (token: string, options: {
        onSuccess: (result: any) => void;
        onPending: (result: any) => void;
        onError: (result: any) => void;
        onClose: () => void;
      }) => void;
    };
  }
}

export const midtransService = new MidtransService();