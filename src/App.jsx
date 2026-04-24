import { useState } from 'react'
import { HashRouter as Router, Routes, Route, Link, useLocation } from 'react-router-dom'

// Screen imports
import SplashScreen from './screens/SplashScreen'
import LanguageSelection from './screens/LanguageSelection'
import RoleSelection from './screens/RoleSelection'
import PhoneEntry from './screens/PhoneEntry'
import SkillsSelection from './screens/SkillsSelection'
import LocationAvailability from './screens/LocationAvailability'
import WorkerProfile from './screens/WorkerProfileSetup'
import JobFeed from './screens/JobFeed'
import JobSearch from './screens/JobSearch'
import JobDetail from './screens/JobDetail'
import QuickApply from './screens/QuickApply'
import MyJobs from './screens/MyJobs'
import WorkerProfilePage from './screens/WorkerProfilePage'
import Notifications from './screens/Notifications'
import EmployerDashboard from './screens/EmployerDashboard'
import PostJob from './screens/PostJob'
import ViewApplicants from './screens/ViewApplicants'
import ChatList from './screens/ChatList'
import ChatScreen from './screens/ChatScreen'
import TrustScore from './screens/TrustScore'
import NGOVerification from './screens/NGOVerification'
import ImpactDashboard from './screens/ImpactDashboard'
import FeatureHighlights from './screens/FeatureHighlights'
import SMSFallback from './screens/SMSFallback'

const screenGroups = [
  {
    label: 'Auth',
    screens: [
      { path: '/', name: 'A1: Splash' },
      { path: '/language', name: 'A2: Language' },
      { path: '/role', name: 'A3: Role' },
      { path: '/phone', name: 'A4: Phone' },
    ]
  },
  {
    label: 'Onboard',
    screens: [
      { path: '/skills', name: 'B1: Skills' },
      { path: '/location', name: 'B2: Location' },
      { path: '/profile-setup', name: 'B3: Profile' },
    ]
  },
  {
    label: 'Worker',
    screens: [
      { path: '/home', name: 'C1: Feed' },
      { path: '/search', name: 'C2: Search' },
      { path: '/job-detail', name: 'C3: Detail' },
      { path: '/apply', name: 'C4: Apply' },
      { path: '/my-jobs', name: 'C5: My Jobs' },
      { path: '/worker-profile', name: 'C6: Profile' },
      { path: '/notifications', name: 'C7: Notifs' },
    ]
  },
  {
    label: 'Employer',
    screens: [
      { path: '/employer', name: 'D1: Dashboard' },
      { path: '/post-job', name: 'D2: Post' },
      { path: '/applicants', name: 'D3: Applicants' },
    ]
  },
  {
    label: 'Chat',
    screens: [
      { path: '/messages', name: 'E1: List' },
      { path: '/chat', name: 'E2: Chat' },
    ]
  },
  {
    label: 'Trust',
    screens: [
      { path: '/trust', name: 'F1: Score' },
      { path: '/ngo', name: 'F2: NGO' },
    ]
  },
  {
    label: 'Demo',
    screens: [
      { path: '/impact', name: 'G1: Impact' },
      { path: '/features', name: 'G2: Features' },
      { path: '/sms', name: 'G3: SMS' },
    ]
  },
]

function NavBar() {
  const location = useLocation()
  return (
    <div style={{ textAlign: 'center', marginBottom: 12 }}>
      <h1 style={{ color: '#22C55E', fontSize: 16, fontWeight: 800, marginBottom: 8, fontFamily: 'Inter, sans-serif', letterSpacing: '-0.5px' }}>
        EmployMe — All Screens
      </h1>
      {screenGroups.map(group => (
        <div key={group.label} className="screen-nav" style={{ marginBottom: 4 }}>
          <span style={{ color: 'rgba(255,255,255,0.3)', fontSize: 10, fontWeight: 700, textTransform: 'uppercase', letterSpacing: 1, minWidth: 52, textAlign: 'right', paddingRight: 4 }}>
            {group.label}
          </span>
          {group.screens.map(s => (
            <Link
              key={s.path}
              to={s.path}
              className={location.pathname === s.path ? 'active' : ''}
            >
              {s.name}
            </Link>
          ))}
        </div>
      ))}
    </div>
  )
}

export default function App() {
  return (
    <Router>
      <div className="screen-wrapper" style={{ flexDirection: 'column' }}>
        <NavBar />
        <div className="mobile-frame">
          <Routes>
            <Route path="/" element={<SplashScreen />} />
            <Route path="/language" element={<LanguageSelection />} />
            <Route path="/role" element={<RoleSelection />} />
            <Route path="/phone" element={<PhoneEntry />} />
            <Route path="/skills" element={<SkillsSelection />} />
            <Route path="/location" element={<LocationAvailability />} />
            <Route path="/profile-setup" element={<WorkerProfile />} />
            <Route path="/home" element={<JobFeed />} />
            <Route path="/search" element={<JobSearch />} />
            <Route path="/job-detail" element={<JobDetail />} />
            <Route path="/apply" element={<QuickApply />} />
            <Route path="/my-jobs" element={<MyJobs />} />
            <Route path="/worker-profile" element={<WorkerProfilePage />} />
            <Route path="/notifications" element={<Notifications />} />
            <Route path="/employer" element={<EmployerDashboard />} />
            <Route path="/post-job" element={<PostJob />} />
            <Route path="/applicants" element={<ViewApplicants />} />
            <Route path="/messages" element={<ChatList />} />
            <Route path="/chat" element={<ChatScreen />} />
            <Route path="/trust" element={<TrustScore />} />
            <Route path="/ngo" element={<NGOVerification />} />
            <Route path="/impact" element={<ImpactDashboard />} />
            <Route path="/features" element={<FeatureHighlights />} />
            <Route path="/sms" element={<SMSFallback />} />
          </Routes>
        </div>
      </div>
    </Router>
  )
}
