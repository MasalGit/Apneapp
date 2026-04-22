const API = 'http://localhost:3000/api';

export async function login() {
  const res = await fetch(`${API}/users/login`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({
      username: 'elsikubios@gmail.com',
      password: 'hYr062vQh6',
    }),
  });
  const data = await res.json();
  localStorage.setItem('token', data.token);
  return data.token;
}

export async function getSleepHours() {
  const token = localStorage.getItem('token');
  const res = await fetch(`${API}/sleep/hours`, {
    headers: { Authorization: `Bearer ${token}` },
  });
  return res.json();
}

export async function getSleepQuality() {
  const token = localStorage.getItem('token');
  const res = await fetch(`${API}/sleep/quality`, {
    headers: { Authorization: `Bearer ${token}` },
  });
  return res.json();
}
