const publicKey = 'BG4X5DcVOgTS40-spPWLGBvdWz4pziCQwYs93YPFO0TK0fSXC5sBPSVV4Y5tDbLvDAdJmb8zIE77VsIXObPiuwk';

const urlBase64ToUint8Array = (base64String) => {
    const padding = '='.repeat((4 - base64String.length % 4) % 4);
    const base64 = (base64String + padding)
      .replace(/\-/g, '+')
      .replace(/_/g, '/');
  
    const rawData = window.atob(base64);
    const outputArray = new Uint8Array(rawData.length);
  
    for (let i = 0; i < rawData.length; ++i) {
      outputArray[i] = rawData.charCodeAt(i);
    }
    return outputArray;
  }

const send = async () => {
    const register = await navigator.serviceWorker.register('/sw.js', { scope: '/' });

    const subscription = await register.pushManager.subscribe({
        userVisibleOnly: true,
        applicationServerKey: urlBase64ToUint8Array(publicKey),
    });

    await fetch('/ps/subscribe', {
        method: 'POST',
        body: JSON.stringify(subscription),
        headers: {
            'content-type': 'application/json'
        }
    });    
}

if ('serviceWorker' in navigator) {
    send()
        .catch(err => console.error(err))
}