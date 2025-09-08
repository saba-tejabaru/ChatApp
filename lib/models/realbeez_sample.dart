class PropertyItem {
  final String id;
  final String title;
  final String location;
  final String price;
  final String imageUrl;
  final String badge;

  PropertyItem({
    required this.id,
    required this.title,
    required this.location,
    required this.price,
    required this.imageUrl,
    required this.badge,
  });
}

class RealBeezSamples {
  static final List<PropertyItem> ownerListings = [
    PropertyItem(
      id: 'o1',
      title: '2 BHK Apartment in HSR Layout',
      location: 'Bengaluru',
      price: '₹72 L',
      imageUrl: 'https://images.unsplash.com/photo-1600585154526-990dced4db0d?q=80&w=1200&auto=format&fit=crop',
      badge: 'Owner',
    ),
    PropertyItem(
      id: 'o2',
      title: '3 BHK Villa in Baner',
      location: 'Pune',
      price: '₹1.25 Cr',
      imageUrl: 'https://images.unsplash.com/photo-1570129477492-45c003edd2be?q=80&w=1200&auto=format&fit=crop',
      badge: 'Owner',
    ),
  ];

  static final List<PropertyItem> verifiedListings = [
    PropertyItem(
      id: 'v1',
      title: '1 BHK Studio near Powai',
      location: 'Mumbai',
      price: '₹48 L',
      imageUrl: 'https://images.unsplash.com/photo-1515263487990-61b07816b324?q=80&w=1200&auto=format&fit=crop',
      badge: 'Verified',
    ),
    PropertyItem(
      id: 'v2',
      title: '4 BHK Penthouse in Jubilee Hills',
      location: 'Hyderabad',
      price: '₹4.2 Cr',
      imageUrl: 'https://images.unsplash.com/photo-1513584684374-8bab748fbf90?q=80&w=1200&auto=format&fit=crop',
      badge: 'Verified',
    ),
  ];

  static final List<PropertyItem> newProjects = [
    PropertyItem(
      id: 'n1',
      title: 'Skylark Residences',
      location: 'Noida Sector 150',
      price: '₹85 L onwards',
      imageUrl: 'https://images.unsplash.com/photo-1528901166007-3784c7dd3653?q=80&w=1200&auto=format&fit=crop',
      badge: 'New Project',
    ),
    PropertyItem(
      id: 'n2',
      title: 'Green Acres Phase 2',
      location: 'Whitefield, Bengaluru',
      price: '₹68 L onwards',
      imageUrl: 'https://images.unsplash.com/photo-1493809842364-78817add7ffb?q=80&w=1200&auto=format&fit=crop',
      badge: 'New Project',
    ),
  ];

  static final List<String> spotlightBanners = [
    'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?q=80&w=1600&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1507089947368-19c1da9775ae?q=80&w=1600&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1449844908441-8829872d2607?q=80&w=1600&auto=format&fit=crop',
  ];
}

