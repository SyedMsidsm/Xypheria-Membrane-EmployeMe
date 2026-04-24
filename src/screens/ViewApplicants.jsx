import { ArrowLeft } from 'lucide-react'
import { EmployerNav } from '../components/BottomNav'
import { useState } from 'react'

export default function ViewApplicants() {
  const [tab, setTab] = useState('All')

  return (
    <div className="mobile-frame-inner" style={{ background: '#F8FAFC', display: 'flex', flexDirection: 'column', height: '100%' }}>
      <div style={{ flex: 1, overflow: 'auto', paddingBottom: 120 }}>
        {/* Header */}
        <div style={{ background: 'white', padding: '16px 20px', borderBottom: '1px solid #E2E8F0' }}>
          <div style={{ display: 'flex', alignItems: 'center', gap: 8 }}>
            <button style={{ background: 'none', border: 'none', cursor: 'pointer', padding: 8, marginLeft: -8 }}>
              <ArrowLeft size={22} color="#0F172A" />
            </button>
            <div style={{ flex: 1, textAlign: 'center' }}>
              <div style={{ fontSize: 20, fontWeight: 700, color: '#0F172A' }}>Applicants</div>
              <div style={{ fontSize: 13, color: '#64748B' }}>Shop Assistant — 47 applicants</div>
            </div>
            <span style={{
              background: '#FFF7ED', color: '#F97316', fontSize: 10, fontWeight: 700,
              padding: '3px 8px', borderRadius: 8,
            }}>🔥 High</span>
          </div>
          <div style={{ display: 'flex', gap: 6, marginTop: 12, overflow: 'auto', scrollbarWidth: 'none' }}>
            {['All (47)', 'New (12)', 'Shortlisted (5)', 'Contacted (8)', 'Hired (2)'].map(t => {
              const isActive = tab === t.split(' ')[0]
              return (
                <button key={t} onClick={() => setTab(t.split(' ')[0])} style={{
                  padding: '6px 12px', borderRadius: 20, whiteSpace: 'nowrap',
                  background: isActive ? '#22C55E' : 'white',
                  color: isActive ? 'white' : '#64748B',
                  border: isActive ? 'none' : '1.5px solid #E2E8F0',
                  fontSize: 12, fontWeight: 600, cursor: 'pointer',
                }}>{t}</button>
              )
            })}
          </div>
        </div>

        <div style={{ padding: '12px 20px 0', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
          <div style={{ display: 'flex', alignItems: 'center', gap: 6 }}>
            <span style={{ fontSize: 14 }}>⭐</span>
            <span style={{ fontSize: 16, fontWeight: 600, color: '#0F172A' }}>Top Matches for You</span>
          </div>
          <button style={{
            padding: '6px 12px', borderRadius: 12, border: '1px solid #E2E8F0',
            background: 'white', fontSize: 11, color: '#64748B', cursor: 'pointer',
          }}>Sort: Distance ▼</button>
        </div>

        {/* Top Match Card */}
        <div style={{ padding: '12px 20px', display: 'flex', flexDirection: 'column', gap: 10 }}>
          <div style={{
            background: 'white', borderRadius: 16, padding: '16px',
            boxShadow: '0 2px 12px rgba(0,0,0,0.08)', borderLeft: '4px solid #D97706',
          }}>
            <div style={{ display: 'flex', justifyContent: 'flex-end', marginBottom: 4 }}>
              <span style={{
                background: '#FFFBEB', color: '#D97706', fontSize: 10, fontWeight: 700,
                padding: '3px 10px', borderRadius: 10,
              }}>⭐ BEST MATCH</span>
            </div>
            <div style={{ display: 'flex', gap: 12, alignItems: 'center' }}>
              <div style={{
                width: 52, height: 52, borderRadius: '50%', background: '#22C55E',
                display: 'flex', alignItems: 'center', justifyContent: 'center',
                fontSize: 22, fontWeight: 700, color: 'white', flexShrink: 0,
              }}>R</div>
              <div style={{ flex: 1 }}>
                <div style={{ fontSize: 16, fontWeight: 700, color: '#0F172A' }}>Raju Kumar</div>
                <div style={{ display: 'flex', alignItems: 'center', gap: 6, marginTop: 4 }}>
                  <span style={{ background: '#F0FDF4', color: '#22C55E', fontSize: 11, fontWeight: 700, padding: '2px 8px', borderRadius: 8 }}>🛡️ 87/100</span>
                </div>
                <div style={{ display: 'flex', gap: 4, marginTop: 6, flexWrap: 'wrap' }}>
                  <span style={{ background: '#F0FDF4', color: '#22C55E', fontSize: 10, padding: '2px 8px', borderRadius: 8, fontWeight: 600 }}>✅ Shop Helper</span>
                  <span style={{ background: '#F0FDF4', color: '#22C55E', fontSize: 10, padding: '2px 8px', borderRadius: 8, fontWeight: 600 }}>✅ Cleaning</span>
                </div>
                <div style={{ fontSize: 12, color: '#22C55E', fontWeight: 600, marginTop: 4 }}>🚶 6 min walk from your shop</div>
                <div style={{ fontSize: 12, color: '#22C55E', marginTop: 2 }}>Available: Immediately</div>
              </div>
            </div>
            <div style={{ display: 'flex', gap: 8, marginTop: 8, fontSize: 12 }}>
              <span style={{ color: '#D97706' }}>⭐ 4.8</span>
              <span style={{ color: '#64748B' }}>12 jobs done</span>
              <span style={{ color: '#22C55E', fontWeight: 600 }}>100% show-up</span>
            </div>
            <div style={{ display: 'flex', gap: 8, marginTop: 12 }}>
              <button style={{
                flex: 3, height: 40, borderRadius: 10, background: 'white',
                border: '1.5px solid #E2E8F0', color: '#0F172A', fontSize: 13, fontWeight: 600, cursor: 'pointer',
              }}>💬 Message</button>
              <button style={{
                flex: 2, height: 40, borderRadius: 10, background: '#22C55E',
                color: 'white', fontSize: 13, fontWeight: 700, border: 'none', cursor: 'pointer',
              }}>✅ Shortlist</button>
            </div>
          </div>

          {/* Second applicant */}
          <div style={{
            background: 'white', borderRadius: 16, padding: '16px',
            boxShadow: '0 2px 12px rgba(0,0,0,0.08)',
          }}>
            <div style={{ display: 'flex', gap: 12, alignItems: 'center' }}>
              <div style={{
                width: 44, height: 44, borderRadius: '50%', background: '#3B82F6',
                display: 'flex', alignItems: 'center', justifyContent: 'center',
                fontSize: 18, fontWeight: 700, color: 'white', flexShrink: 0,
              }}>S</div>
              <div style={{ flex: 1 }}>
                <div style={{ fontSize: 15, fontWeight: 700, color: '#0F172A' }}>Suresh Mallya</div>
                <span style={{ background: '#FFF7ED', color: '#F97316', fontSize: 10, fontWeight: 700, padding: '2px 8px', borderRadius: 8 }}>🛡️ 72/100</span>
                <div style={{ display: 'flex', gap: 4, marginTop: 4 }}>
                  <span style={{ background: '#F0FDF4', color: '#22C55E', fontSize: 10, padding: '2px 8px', borderRadius: 8, fontWeight: 600 }}>✅ Delivery</span>
                  <span style={{ background: '#FFF7ED', color: '#F97316', fontSize: 10, padding: '2px 8px', borderRadius: 8, fontWeight: 600 }}>⚠️ Shop</span>
                </div>
                <div style={{ fontSize: 12, color: '#64748B', marginTop: 4 }}>🚶 18 min walk</div>
                <div style={{ fontSize: 12, color: '#64748B' }}>⭐ 4.2 | 5 jobs done</div>
              </div>
            </div>
            <div style={{ display: 'flex', gap: 8, marginTop: 10 }}>
              <button style={{
                flex: 1, height: 36, borderRadius: 10, background: 'white',
                border: '1.5px solid #E2E8F0', color: '#0F172A', fontSize: 12, fontWeight: 600, cursor: 'pointer',
              }}>Message</button>
              <button style={{
                flex: 1, height: 36, borderRadius: 10, background: '#22C55E',
                color: 'white', fontSize: 12, fontWeight: 700, border: 'none', cursor: 'pointer',
              }}>Shortlist</button>
            </div>
          </div>

          {/* Contacted Card */}
          <div style={{
            background: '#EFF6FF', borderRadius: 16, padding: '16px',
          }}>
            <span style={{ background: '#3B82F6', color: 'white', fontSize: 10, fontWeight: 700, padding: '3px 10px', borderRadius: 8 }}>💬 CONTACTED</span>
            <div style={{ display: 'flex', gap: 12, alignItems: 'center', marginTop: 10 }}>
              <div style={{
                width: 44, height: 44, borderRadius: '50%', background: '#F97316',
                display: 'flex', alignItems: 'center', justifyContent: 'center',
                fontSize: 18, fontWeight: 700, color: 'white', flexShrink: 0,
              }}>P</div>
              <div style={{ flex: 1 }}>
                <div style={{ fontSize: 15, fontWeight: 700, color: '#0F172A' }}>Priya Devi</div>
                <div style={{ fontSize: 12, color: '#3B82F6', marginTop: 4 }}>Last message: 2 hours ago</div>
                <span style={{ fontSize: 12, color: '#3B82F6', fontWeight: 600, cursor: 'pointer' }}>View Conversation →</span>
              </div>
            </div>
            <button style={{
              width: '100%', height: 36, borderRadius: 10, background: '#22C55E',
              color: 'white', fontSize: 13, fontWeight: 700, border: 'none', cursor: 'pointer', marginTop: 10,
            }}>Mark as Hired</button>
          </div>
        </div>
      </div>

      {/* Boost banner */}
      <div style={{
        position: 'absolute', bottom: 64, left: 0, right: 0,
        background: 'linear-gradient(135deg, #22C55E, #16A34A)',
        padding: '12px 20px', display: 'flex', alignItems: 'center',
        justifyContent: 'space-between',
      }}>
        <div>
          <span style={{ fontSize: 13, fontWeight: 700, color: 'white' }}>📢 Boost post for more workers</span>
          <span style={{ fontSize: 11, color: 'rgba(255,255,255,0.8)', display: 'block' }}>₹99 for 3x visibility</span>
        </div>
        <button style={{
          padding: '8px 16px', borderRadius: 10, background: 'white',
          color: '#22C55E', fontSize: 13, fontWeight: 700, border: 'none', cursor: 'pointer',
        }}>Boost Now</button>
      </div>

      <EmployerNav active="applicants" />
    </div>
  )
}
