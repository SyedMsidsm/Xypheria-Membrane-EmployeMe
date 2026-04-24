import { Home, Search, ClipboardList, MessageCircle, User, Settings, Users, BarChart3 } from 'lucide-react'
import { Link, useLocation } from 'react-router-dom'

export function WorkerNav({ active = 'home' }) {
  const items = [
    { id: 'home', icon: Home, label: 'Home', labelKn: 'ಮನೆ', path: '/home' },
    { id: 'search', icon: Search, label: 'Search', labelKn: 'ಹುಡುಕಿ', path: '/search' },
    { id: 'jobs', icon: ClipboardList, label: 'My Jobs', labelKn: 'ನನ್ನ ಕೆಲಸ', path: '/my-jobs' },
    { id: 'messages', icon: MessageCircle, label: 'Messages', labelKn: 'ಸಂದೇಶ', path: '/messages' },
    { id: 'profile', icon: User, label: 'Profile', labelKn: 'ಪ್ರೊಫೈಲ್', path: '/worker-profile' },
  ]

  return (
    <div className="bottom-nav">
      {items.map(item => (
        <Link key={item.id} to={item.path} className={`bottom-nav-item ${active === item.id ? 'active' : ''}`}>
          <item.icon size={24} strokeWidth={active === item.id ? 2.5 : 1.8} />
          <span>{item.label}</span>
        </Link>
      ))}
    </div>
  )
}

export function EmployerNav({ active = 'home' }) {
  const items = [
    { id: 'home', icon: Home, label: 'Dashboard', labelKn: 'ಡ್ಯಾಶ್‌ಬೋರ್ಡ್', path: '/employer' },
    { id: 'jobs', icon: ClipboardList, label: 'Jobs', labelKn: 'ಕೆಲಸ', path: '/post-job' },
    { id: 'applicants', icon: Users, label: 'Applicants', labelKn: 'ಅರ್ಜಿದಾರರು', path: '/applicants' },
    { id: 'messages', icon: MessageCircle, label: 'Messages', labelKn: 'ಸಂದೇಶ', path: '/messages' },
    { id: 'account', icon: Settings, label: 'Account', labelKn: 'ಖಾತೆ', path: '/employer' },
  ]

  return (
    <div className="bottom-nav">
      {items.map(item => (
        <Link key={item.id} to={item.path} className={`bottom-nav-item ${active === item.id ? 'active' : ''}`}>
          <item.icon size={24} strokeWidth={active === item.id ? 2.5 : 1.8} />
          <span>{item.label}</span>
        </Link>
      ))}
    </div>
  )
}
