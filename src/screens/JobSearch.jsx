import { ArrowLeft, Search, X } from 'lucide-react'
import { WorkerNav } from '../components/BottomNav'
import { useState } from 'react'

export default function JobSearch() {
  const [distance, setDistance] = useState('2km')

  return (
    <div className="mobile-frame-inner fade-in" style={{ background: 'var(--color-bg)', display: 'flex', flexDirection: 'column', height: '100%' }}>
      <div style={{ flex: 1, overflow: 'auto', paddingBottom: 130 }}>
        {/* Header */}
        <div style={{ padding: '16px 20px 0', display: 'flex', alignItems: 'center', gap: 8 }}>
          <button style={{ background: 'var(--color-card)', border: '1px solid var(--color-border)', borderRadius: '50%', cursor: 'pointer', padding: 10, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
            <ArrowLeft size={20} color="var(--color-text)" />
          </button>
          <div style={{ textAlign: 'center', flex: 1 }}>
            <div style={{ fontSize: 18, fontWeight: 800, color: 'var(--color-text)' }}>Search Jobs</div>
            <div style={{ fontSize: 12, color: 'var(--color-caption)', fontWeight: 500 }}>ಕೆಲಸ ಹುಡುಕಿ</div>
          </div>
          <div style={{ width: 42 }} />
        </div>

        {/* Search Bar */}
        <div style={{ padding: '20px 20px 0' }}>
          <div className="input-field" style={{
            display: 'flex', alignItems: 'center', padding: '0 16px', gap: 10,
            background: 'var(--color-card)', borderColor: 'var(--color-primary)',
            boxShadow: '0 4px 16px rgba(16,185,129,0.1)',
          }}>
            <Search size={20} color="var(--color-primary)" />
            <input type="text" placeholder="What job are you looking for?" style={{
              border: 'none', background: 'transparent', flex: 1, fontSize: 15, color: 'var(--color-text)', outline: 'none'
            }} />
            <X size={18} color="var(--color-caption)" style={{ cursor: 'pointer' }} />
          </div>
        </div>

        {/* Recent searches */}
        <div style={{ padding: '16px 20px 0' }}>
          <span style={{ fontSize: 13, color: 'var(--color-text-secondary)', fontWeight: 500 }}>Recent searches</span>
          <div style={{ display: 'flex', gap: 8, marginTop: 10, overflow: 'auto', scrollbarWidth: 'none' }}>
            {['Shop Helper', 'Cook', 'Delivery'].map(s => (
              <span key={s} className="tap-feedback" style={{
                padding: '8px 14px', borderRadius: 20, background: 'var(--color-card)',
                border: '1px solid var(--color-border)', fontSize: 13, color: 'var(--color-text)',
                display: 'flex', alignItems: 'center', gap: 6, whiteSpace: 'nowrap', fontWeight: 500,
              }}>
                {s} <X size={12} color="var(--color-caption)" />
              </span>
            ))}
          </div>
        </div>

        {/* Filter Panels */}
        <div style={{ padding: '24px 20px 0', display: 'flex', flexDirection: 'column', gap: 16 }}>
          {/* Distance */}
          <div className="card-shadow" style={{ background: 'var(--color-card)', borderRadius: 16, padding: '16px', border: '1px solid var(--color-border)' }}>
            <div style={{ fontSize: 15, fontWeight: 700, color: 'var(--color-text)', marginBottom: 4 }}>📍 Distance from you</div>
            <div style={{ fontSize: 12, color: 'var(--color-text-secondary)', marginBottom: 16 }}>ನಿಮ್ಮಿಂದ ದೂರ</div>
            <div style={{ position: 'relative', height: 40 }}>
              <div style={{ position: 'absolute', top: 16, left: 0, right: 0, height: 4, borderRadius: 2, background: 'var(--color-border)' }}>
                <div style={{ width: '30%', height: '100%', borderRadius: 2, background: 'var(--color-primary)' }} />
              </div>
              <div style={{
                position: 'absolute', top: 8, left: '28%',
                width: 20, height: 20, borderRadius: '50%', background: 'var(--color-primary)',
                border: '3px solid var(--color-card)', boxShadow: '0 2px 6px rgba(16,185,129,0.3)',
              }} />
              <div style={{
                position: 'absolute', top: -10, left: 'calc(28% - 10px)',
                background: 'var(--color-text)', color: 'white', fontSize: 11, fontWeight: 700,
                padding: '2px 8px', borderRadius: 6,
              }}>2km</div>
              <span style={{ position: 'absolute', left: 0, bottom: 0, fontSize: 11, color: 'var(--color-caption)' }}>500m</span>
              <span style={{ position: 'absolute', right: 0, bottom: 0, fontSize: 11, color: 'var(--color-caption)' }}>10km</span>
            </div>
            <div style={{ display: 'flex', gap: 8, marginTop: 16 }}>
              {['500m', '1km', '2km', '5km'].map(d => (
                <button key={d} className="tap-feedback" onClick={() => setDistance(d)} style={{
                  padding: '8px 16px', borderRadius: 12,
                  border: distance === d ? '1px solid var(--color-primary)' : '1px solid var(--color-border)',
                  background: distance === d ? 'var(--color-primary-light)' : 'var(--color-card)',
                  color: distance === d ? 'var(--color-primary-dark)' : 'var(--color-text-secondary)',
                  fontSize: 13, fontWeight: 600, cursor: 'pointer',
                }}>{d}</button>
              ))}
            </div>
          </div>

          {/* Job Type */}
          <div className="card-shadow" style={{ background: 'var(--color-card)', borderRadius: 16, padding: '16px', border: '1px solid var(--color-border)' }}>
            <div style={{ fontSize: 15, fontWeight: 700, color: 'var(--color-text)', marginBottom: 4 }}>💼 Job Type</div>
            <div style={{ fontSize: 12, color: 'var(--color-text-secondary)', marginBottom: 16 }}>ಕೆಲಸದ ಪ್ರಕಾರ</div>
            <div style={{ display: 'flex', gap: 8, flexWrap: 'wrap' }}>
              {['Full Time', 'Part Time', 'Daily Wage', 'Weekend Only'].map((t, i) => (
                <button key={t} className="tap-feedback" style={{
                  padding: '8px 14px', borderRadius: 12,
                  border: i < 2 ? '1px solid var(--color-primary)' : '1px solid var(--color-border)',
                  background: i < 2 ? 'var(--color-primary)' : 'var(--color-card)',
                  color: i < 2 ? 'white' : 'var(--color-text)',
                  fontSize: 13, fontWeight: 600, cursor: 'pointer',
                }}>{i < 2 ? '✓ ' : ''}{t}</button>
              ))}
            </div>
          </div>

          {/* Pay Range */}
          <div className="card-shadow" style={{ background: 'var(--color-card)', borderRadius: 16, padding: '16px', border: '1px solid var(--color-border)' }}>
            <div style={{ fontSize: 15, fontWeight: 700, color: 'var(--color-text)', marginBottom: 4 }}>💰 Pay Range</div>
            <div style={{ fontSize: 12, color: 'var(--color-text-secondary)', marginBottom: 16 }}>ಸಂಬಳ</div>
            <div style={{ display: 'flex', gap: 10 }}>
              <div style={{
                flex: 1, height: 48, borderRadius: 12, border: '1px solid var(--color-border)',
                display: 'flex', alignItems: 'center', padding: '0 12px', background: 'var(--color-bg)',
              }}>
                <span style={{ color: 'var(--color-caption)', marginRight: 4 }}>Min ₹</span>
                <span style={{ fontWeight: 600, color: 'var(--color-text)' }}>300</span>
              </div>
              <div style={{
                flex: 1, height: 48, borderRadius: 12, border: '1px solid var(--color-border)',
                display: 'flex', alignItems: 'center', padding: '0 12px', background: 'var(--color-bg)',
              }}>
                <span style={{ color: 'var(--color-caption)', marginRight: 4 }}>Max ₹</span>
                <span style={{ fontWeight: 600, color: 'var(--color-text)' }}>800</span>
              </div>
            </div>
            <div style={{ display: 'flex', gap: 0, marginTop: 12, border: '1px solid var(--color-border)', borderRadius: 10, overflow: 'hidden' }}>
              {['Day', 'Month', 'Hour'].map((p, i) => (
                <button key={p} className="tap-feedback" style={{
                  flex: 1, padding: '10px 0', border: 'none',
                  background: i === 0 ? 'var(--color-primary)' : 'var(--color-card)',
                  color: i === 0 ? 'white' : 'var(--color-text-secondary)',
                  fontSize: 13, fontWeight: 600, cursor: 'pointer',
                  borderRight: i < 2 ? '1px solid var(--color-border)' : 'none',
                }}>per {p}</button>
              ))}
            </div>
          </div>

          {/* Availability */}
          <div className="card-shadow" style={{ background: 'var(--color-card)', borderRadius: 16, padding: '16px', border: '1px solid var(--color-border)' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
              <div>
                <div style={{ fontSize: 15, fontWeight: 700, color: 'var(--color-text)' }}>📅 Match my availability</div>
                <div style={{ fontSize: 13, color: 'var(--color-text-secondary)', marginTop: 4 }}>Only show jobs on: Mon-Fri</div>
              </div>
              <div style={{
                width: 44, height: 24, borderRadius: 12, background: 'var(--color-primary)',
                position: 'relative', cursor: 'pointer',
              }}>
                <div style={{
                  width: 20, height: 20, borderRadius: '50%', background: 'white',
                  position: 'absolute', top: 2, right: 2,
                  boxShadow: '0 1px 3px rgba(0,0,0,0.2)',
                }} />
              </div>
            </div>
          </div>
        </div>
      </div>

      {/* Bottom */}
      <div style={{
        position: 'absolute', bottom: 64, left: 0, right: 0,
        background: 'var(--color-card)', padding: '12px 20px 16px',
        borderTop: '1px solid var(--color-border)',
      }}>
        <p className="tap-feedback" style={{ textAlign: 'center', fontSize: 13, color: 'var(--color-text-secondary)', marginBottom: 12, cursor: 'pointer', fontWeight: 600 }}>
          Reset Filters
        </p>
        <button className="btn-primary">
          Show 47 Jobs
        </button>
      </div>

      <WorkerNav active="search" />
    </div>
  )
}
