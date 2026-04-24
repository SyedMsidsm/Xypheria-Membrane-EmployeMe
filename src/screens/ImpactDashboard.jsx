import { useEffect, useState } from 'react'

function AnimatedCounter({ end, duration = 2000 }) {
  const [count, setCount] = useState(0)
  useEffect(() => {
    let start = 0
    const step = end / (duration / 16)
    const timer = setInterval(() => {
      start += step
      if (start >= end) { setCount(end); clearInterval(timer) }
      else setCount(Math.floor(start))
    }, 16)
    return () => clearInterval(timer)
  }, [end, duration])
  return count.toLocaleString()
}

export default function ImpactDashboard() {
  return (
    <div className="mobile-frame-inner" style={{
      background: '#0F172A', display: 'flex', flexDirection: 'column', height: '100%',
    }}>
      <div style={{ flex: 1, overflow: 'auto', paddingBottom: 20 }}>
        {/* Top Bar */}
        <div style={{
          padding: '16px 20px', display: 'flex', justifyContent: 'space-between', alignItems: 'center',
        }}>
          <div>
            <span style={{ fontSize: 18, fontWeight: 800, color: 'white', letterSpacing: '-0.5px' }}>EmployMe</span>
            <span style={{ fontSize: 11, color: '#94A3B8', display: 'block', marginTop: 2 }}>Karnataka Pilot</span>
          </div>
          <div style={{
            display: 'flex', alignItems: 'center', gap: 6,
            background: 'rgba(34,197,94,0.15)', padding: '6px 12px', borderRadius: 20,
          }}>
            <div style={{ width: 8, height: 8, borderRadius: '50%', background: '#22C55E' }} className="pulse-ring" />
            <span style={{ fontSize: 12, fontWeight: 600, color: '#22C55E' }}>Live Impact Data</span>
          </div>
        </div>

        {/* Hero Metric */}
        <div style={{ textAlign: 'center', padding: '20px 20px 24px' }}>
          <div className="count-up" style={{ fontSize: 64, fontWeight: 800, color: 'white', lineHeight: 1 }}>
            <AnimatedCounter end={10247} />
          </div>
          <p style={{ fontSize: 16, color: '#22C55E', fontWeight: 600, marginTop: 8 }}>Jobs Matched This Month</p>
          <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'center', gap: 6, marginTop: 6 }}>
            <span style={{ fontSize: 13, color: '#22C55E' }}>↑ 23% from last month</span>
          </div>
        </div>

        {/* 4 Stat Cards */}
        <div style={{ padding: '0 20px', display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 10 }}>
          {[
            { label: 'Workers Registered', value: '3,842', sub: '↑ 847 new this week', color: '#22C55E' },
            { label: 'Businesses Active', value: '847', sub: '50+ joined today', color: '#3B82F6' },
            { label: 'Avg Match Time', value: '4.2 min', sub: '98% faster', color: '#22C55E' },
            { label: 'Wages Facilitated', value: '₹18.4L', sub: 'This month', color: '#22C55E' },
          ].map(stat => (
            <div key={stat.label} style={{
              background: '#1E293B', borderRadius: 16, padding: '16px',
              border: '1px solid rgba(255,255,255,0.06)',
            }}>
              <div style={{ fontSize: 28, fontWeight: 800, color: 'white' }}>{stat.value}</div>
              <div style={{ fontSize: 13, color: stat.color, marginTop: 4 }}>{stat.sub}</div>
              <div style={{ fontSize: 11, color: '#94A3B8', marginTop: 4 }}>{stat.label}</div>
              {/* Mini chart */}
              <div style={{ display: 'flex', gap: 3, marginTop: 8, alignItems: 'flex-end' }}>
                {[30, 45, 35, 55, 70, 60, 85].map((h, i) => (
                  <div key={i} style={{
                    flex: 1, height: h * 0.3, borderRadius: 2,
                    background: i === 6 ? stat.color : `${stat.color}40`,
                  }} />
                ))}
              </div>
            </div>
          ))}
        </div>

        {/* Live Map */}
        <div style={{ padding: '16px 20px 0' }}>
          <div style={{
            background: '#1E293B', borderRadius: 16, padding: '16px', height: 180,
            position: 'relative', overflow: 'hidden', border: '1px solid rgba(255,255,255,0.06)',
          }}>
            {/* Map lines */}
            <svg width="100%" height="100%" style={{ position: 'absolute', inset: 0 }}>
              {/* Coast line */}
              <path d="M300,20 C280,60 290,100 310,150" stroke="rgba(59,130,246,0.3)" strokeWidth="2" fill="none" />
              {/* Roads */}
              <line x1="40" y1="60" x2="300" y2="60" stroke="rgba(255,255,255,0.08)" strokeWidth="1" />
              <line x1="40" y1="100" x2="300" y2="100" stroke="rgba(255,255,255,0.08)" strokeWidth="1" />
              <line x1="100" y1="20" x2="100" y2="160" stroke="rgba(255,255,255,0.08)" strokeWidth="1" />
              <line x1="200" y1="20" x2="200" y2="160" stroke="rgba(255,255,255,0.08)" strokeWidth="1" />
            </svg>

            {/* Activity dots */}
            {[
              { x: 120, y: 55, size: 16, label: 'Kodialbail' },
              { x: 200, y: 45, size: 12, label: 'Hampankatta' },
              { x: 80, y: 100, size: 8, label: 'Surathkal' },
              { x: 250, y: 90, size: 14, label: 'City Centre' },
              { x: 160, y: 120, size: 6 },
            ].map((dot, i) => (
              <div key={i}>
                <div style={{
                  position: 'absolute', left: dot.x, top: dot.y,
                  width: dot.size, height: dot.size, borderRadius: '50%',
                  background: '#22C55E', opacity: 0.8,
                }} />
                <div className="pulse-ring" style={{
                  position: 'absolute', left: dot.x - 4, top: dot.y - 4,
                  width: dot.size + 8, height: dot.size + 8, borderRadius: '50%',
                  border: '1px solid rgba(34,197,94,0.3)',
                }} />
                {dot.label && (
                  <span style={{
                    position: 'absolute', left: dot.x + dot.size + 4, top: dot.y - 4,
                    fontSize: 9, color: 'rgba(255,255,255,0.6)', whiteSpace: 'nowrap',
                  }}>{dot.label}</span>
                )}
              </div>
            ))}

            {/* Urgent pin */}
            <div style={{
              position: 'absolute', left: 150, top: 75,
              fontSize: 10, color: '#EF4444', fontWeight: 700,
              background: 'rgba(239,68,68,0.15)', padding: '2px 8px', borderRadius: 8,
            }}>🔴 3 urgent</div>
          </div>
        </div>

        {/* Impact Categories */}
        <div style={{ padding: '16px 20px 0' }}>
          <span style={{ fontSize: 14, fontWeight: 600, color: 'white', marginBottom: 10, display: 'block' }}>Who We're Helping</span>
          <div style={{ display: 'flex', gap: 8 }}>
            {[
              { icon: '👷', label: '2,841 Daily Workers' },
              { icon: '👩', label: '847 Women' },
              { icon: '🎓', label: '634 Students' },
            ].map(c => (
              <div key={c.label} style={{
                flex: 1, background: '#1E293B', borderRadius: 12, padding: '10px 8px',
                textAlign: 'center', border: '1px solid rgba(255,255,255,0.06)',
              }}>
                <span style={{ fontSize: 20 }}>{c.icon}</span>
                <div style={{ fontSize: 10, color: '#94A3B8', marginTop: 4 }}>{c.label}</div>
              </div>
            ))}
          </div>
        </div>

        {/* SDG Alignment */}
        <div style={{ padding: '16px 20px 0' }}>
          <span style={{ fontSize: 12, fontWeight: 600, color: '#94A3B8', display: 'block', marginBottom: 8 }}>UN Sustainable Development Goals</span>
          <div style={{ display: 'flex', gap: 8 }}>
            {[
              { num: 8, title: 'Decent Work', color: '#9E1B32' },
              { num: 10, title: 'Reduced Inequalities', color: '#DD1367' },
              { num: 1, title: 'No Poverty', color: '#E5243B' },
            ].map(sdg => (
              <div key={sdg.num} style={{
                flex: 1, background: sdg.color, borderRadius: 10, padding: '12px 8px', textAlign: 'center',
              }}>
                <div style={{ fontSize: 20, fontWeight: 800, color: 'white' }}>{sdg.num}</div>
                <div style={{ fontSize: 9, color: 'rgba(255,255,255,0.8)', marginTop: 2 }}>{sdg.title}</div>
              </div>
            ))}
          </div>
        </div>

        {/* Quote */}
        <div style={{ padding: '16px 20px' }}>
          <div style={{
            background: '#1E293B', borderRadius: 12, padding: '16px',
            borderLeft: '4px solid #22C55E',
          }}>
            <p style={{ fontSize: 14, color: 'white', fontStyle: 'italic', lineHeight: 1.6, textAlign: 'center' }}>
              "For Raju and 500 million like him — their first digital job, just 8 minutes away."
            </p>
            <p style={{ fontSize: 12, color: '#94A3B8', textAlign: 'center', marginTop: 8 }}>- Team EmployMe, MITE</p>
          </div>
        </div>

        {/* Logo */}
        <div style={{ textAlign: 'center', padding: '0 0 16px' }}>
          <span style={{ fontSize: 18, fontWeight: 800, color: 'rgba(255,255,255,0.3)', letterSpacing: '-0.5px' }}>EmployMe</span>
        </div>
      </div>
    </div>
  )
}
