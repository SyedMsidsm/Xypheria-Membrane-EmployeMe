import { useState } from 'react'
import { WorkerNav } from '../components/BottomNav'

export default function MyJobs() {
  const [tab, setTab] = useState('All')

  return (
    <div className="mobile-frame-inner" style={{ background: '#F8FAFC', display: 'flex', flexDirection: 'column', height: '100%' }}>
      <div style={{ flex: 1, overflow: 'auto', paddingBottom: 72 }}>
        {/* Header */}
        <div style={{ background: 'white', padding: '16px 20px', borderBottom: '1px solid #E2E8F0' }}>
          <h1 style={{ fontSize: 22, fontWeight: 700, color: '#0F172A' }}>My Jobs</h1>
          <p style={{ fontSize: 13, color: '#64748B' }}>ನನ್ನ ಕೆಲಸಗಳು</p>
          <div style={{ display: 'flex', gap: 8, marginTop: 12, overflow: 'auto', scrollbarWidth: 'none' }}>
            {['All (8)', 'Pending (3)', 'Accepted (2)', 'Completed (3)'].map(t => {
              const isActive = tab === t.split(' ')[0]
              return (
                <button key={t} onClick={() => setTab(t.split(' ')[0])} style={{
                  padding: '8px 14px', borderRadius: 20, whiteSpace: 'nowrap',
                  background: isActive ? '#22C55E' : 'white',
                  color: isActive ? 'white' : '#64748B',
                  border: isActive ? 'none' : '1.5px solid #E2E8F0',
                  fontSize: 13, fontWeight: 600, cursor: 'pointer',
                }}>{t}</button>
              )
            })}
          </div>
        </div>

        {/* Stats Banner */}
        <div style={{
          margin: '12px 20px', background: 'linear-gradient(135deg, #22C55E, #16A34A)',
          borderRadius: 16, padding: '14px 16px', display: 'flex', justifyContent: 'space-around',
        }}>
          {[
            { num: '3', label: 'Pending', bg: 'rgba(249,115,22,0.2)' },
            { num: '2', label: 'Offers', bg: 'rgba(34,197,94,0.3)' },
            { num: '₹8,400', label: 'Earned', bg: 'rgba(59,130,246,0.2)' },
          ].map(s => (
            <div key={s.label} style={{ textAlign: 'center' }}>
              <div style={{
                background: s.bg, borderRadius: 12, padding: '6px 12px', display: 'inline-block',
              }}>
                <div style={{ fontSize: 18, fontWeight: 800, color: 'white' }}>{s.num}</div>
                <div style={{ fontSize: 11, color: 'rgba(255,255,255,0.8)' }}>{s.label}</div>
              </div>
            </div>
          ))}
        </div>

        {/* New Activity */}
        <div style={{ padding: '8px 20px 0', display: 'flex', alignItems: 'center', gap: 8 }}>
          <span style={{ fontSize: 16, fontWeight: 700, color: '#0F172A' }}>New Activity</span>
          <div style={{ width: 8, height: 8, borderRadius: '50%', background: '#F97316' }} />
          <span style={{ background: '#FFF7ED', color: '#F97316', fontSize: 10, fontWeight: 700, padding: '2px 8px', borderRadius: 8 }}>New</span>
        </div>

        <div style={{ padding: '12px 20px', display: 'flex', flexDirection: 'column', gap: 12 }}>
          {/* Offer Card */}
          <div style={{
            background: 'white', borderRadius: 16, overflow: 'hidden',
            boxShadow: '0 2px 12px rgba(0,0,0,0.08)', borderLeft: '4px solid #22C55E',
          }}>
            <div style={{ background: '#F0FDF4', padding: '8px 16px', display: 'flex', alignItems: 'center', gap: 8 }}>
              <span style={{ fontSize: 14 }}>🎉</span>
              <span style={{ fontSize: 13, fontWeight: 700, color: '#22C55E' }}>JOB OFFER RECEIVED</span>
            </div>
            <div style={{ padding: '14px 16px' }}>
              <div style={{ display: 'flex', alignItems: 'center', gap: 12 }}>
                <div style={{
                  width: 44, height: 44, borderRadius: '50%', background: '#F0FDF4',
                  display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: 18,
                }}>🏪</div>
                <div style={{ flex: 1 }}>
                  <div style={{ fontSize: 16, fontWeight: 700, color: '#0F172A' }}>Shop Assistant</div>
                  <div style={{ fontSize: 14, color: '#64748B' }}>Sri Ganesh Provision Store</div>
                  <div style={{ display: 'flex', gap: 8, marginTop: 4 }}>
                    <span style={{ fontSize: 12, color: '#22C55E', fontWeight: 600 }}>📍 6 min walk</span>
                    <span style={{ fontSize: 14, fontWeight: 800, color: '#22C55E' }}>₹12,000/month</span>
                  </div>
                </div>
              </div>
              <div style={{ display: 'flex', flexWrap: 'wrap', gap: 6, marginTop: 8, alignItems: 'center' }}>
                <span style={{ background: '#F0FDF4', color: '#22C55E', padding: '4px 10px', borderRadius: 12, fontSize: 11, fontWeight: 600 }}>✅ Offer Received</span>
                <span style={{ fontSize: 12, color: '#94A3B8' }}>2 hours ago</span>
              </div>
              <div style={{ display: 'flex', gap: 8, marginTop: 12 }}>
                <button style={{
                  flex: 2, height: 44, borderRadius: 12, background: '#22C55E',
                  color: 'white', fontWeight: 700, fontSize: 14, border: 'none', cursor: 'pointer',
                }}>✓ Accept Offer</button>
                <button style={{
                  flex: 1, height: 44, borderRadius: 12, background: 'white',
                  border: '1.5px solid #EF4444', color: '#EF4444', fontWeight: 600, fontSize: 14, cursor: 'pointer',
                }}>✗ Decline</button>
              </div>
            </div>
          </div>

          {/* Pending Card */}
          <div style={{
            background: 'white', borderRadius: 16, padding: '16px',
            boxShadow: '0 2px 12px rgba(0,0,0,0.08)',
          }}>
            <div style={{ display: 'flex', alignItems: 'center', gap: 12 }}>
              <div style={{
                width: 44, height: 44, borderRadius: '50%', background: '#EFF6FF',
                display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: 18,
              }}>💰</div>
              <div style={{ flex: 1 }}>
                <div style={{ fontSize: 16, fontWeight: 700, color: '#0F172A' }}>Cashier</div>
                <div style={{ fontSize: 14, color: '#64748B' }}>FreshMart Supermarket</div>
                <div style={{ display: 'flex', gap: 8, marginTop: 4 }}>
                  <span style={{ fontSize: 12, color: '#64748B' }}>🚶 18 min walk</span>
                  <span style={{ fontSize: 14, fontWeight: 700, color: '#22C55E' }}>₹10,000/mo</span>
                </div>
              </div>
            </div>
            <div style={{ display: 'flex', alignItems: 'center', gap: 8, marginTop: 10 }}>
              <span style={{ background: '#FFF7ED', color: '#F97316', padding: '4px 10px', borderRadius: 12, fontSize: 11, fontWeight: 600 }}>⏳ Pending Review</span>
              <span style={{ fontSize: 12, color: '#94A3B8' }}>Applied 1 day ago</span>
            </div>
            <button style={{
              width: '100%', height: 40, borderRadius: 12, background: 'white',
              border: '1.5px solid #22C55E', color: '#22C55E', fontWeight: 600,
              fontSize: 13, cursor: 'pointer', marginTop: 10,
            }}>Message Employer</button>
          </div>

          {/* Completed Card */}
          <div style={{
            background: '#F8FAFC', borderRadius: 16, padding: '16px',
            border: '1px solid #E2E8F0',
          }}>
            <div style={{ display: 'flex', alignItems: 'center', gap: 12 }}>
              <div style={{
                width: 44, height: 44, borderRadius: '50%', background: '#F0FDF4',
                display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: 18,
              }}>🍳</div>
              <div style={{ flex: 1 }}>
                <div style={{ fontSize: 16, fontWeight: 700, color: '#0F172A' }}>Kitchen Helper</div>
                <div style={{ fontSize: 14, color: '#64748B' }}>Hotel Udupi Delights</div>
              </div>
            </div>
            <div style={{ display: 'flex', alignItems: 'center', gap: 8, marginTop: 10 }}>
              <span style={{ background: '#F0FDF4', color: '#22C55E', padding: '4px 10px', borderRadius: 12, fontSize: 11, fontWeight: 600 }}>✅ Completed</span>
              <span style={{ fontSize: 12, color: '#64748B' }}>3 days | ₹1,500 earned</span>
            </div>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginTop: 10 }}>
              <span style={{ fontSize: 13, color: '#D97706', fontWeight: 600, cursor: 'pointer' }}>⭐ Rate this employer →</span>
              <span style={{ background: '#F0FDF4', color: '#22C55E', fontSize: 11, fontWeight: 600, padding: '3px 8px', borderRadius: 8 }}>Rehire available</span>
            </div>
          </div>
        </div>
      </div>

      <WorkerNav active="jobs" />
    </div>
  )
}
