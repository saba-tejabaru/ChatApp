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
    PropertyItem(
      id: 'o3',
      title: '2 BHK in Wakad',
      location: 'Pune',
      price: '₹82 L',
      imageUrl: 'https://images.unsplash.com/photo-1560518883-ce09059eeffa?q=80&w=1200&auto=format&fit=crop',
      badge: 'Owner',
    ),
    PropertyItem(
      id: 'o4',
      title: '1 BHK near Gachibowli',
      location: 'Hyderabad',
      price: '₹52 L',
      imageUrl: 'https://images.unsplash.com/photo-1519710164239-da123dc03ef4?q=80&w=1200&auto=format&fit=crop',
      badge: 'Owner',
    ),
    PropertyItem(
      id: 'o5',
      title: '3 BHK in Noida Sec 150',
      location: 'Noida',
      price: '₹1.35 Cr',
      imageUrl: 'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?q=80&w=1200&auto=format&fit=crop',
      badge: 'Owner',
    ),
    PropertyItem(
      id: 'o6',
      title: '2 BHK near Kondapur',
      location: 'Hyderabad',
      price: '₹78 L',
      imageUrl: 'https://images.unsplash.com/photo-1499914485622-a88fac536970?q=80&w=1200&auto=format&fit=crop',
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
    PropertyItem(
      id: 'v3',
      title: '2 BHK in Andheri East',
      location: 'Mumbai',
      price: '₹1.1 Cr',
      imageUrl: 'https://images.unsplash.com/photo-1597047084897-51e81819a499?q=80&w=1200&auto=format&fit=crop',
      badge: 'Verified',
    ),
    PropertyItem(
      id: 'v4',
      title: '3 BHK in Indiranagar',
      location: 'Bengaluru',
      price: '₹2.1 Cr',
      imageUrl: 'https://images.unsplash.com/photo-1494526585095-c41746248156?q=80&w=1200&auto=format&fit=crop',
      badge: 'Verified',
    ),
    PropertyItem(
      id: 'v5',
      title: '2 BHK in Whitefield',
      location: 'Bengaluru',
      price: '₹95 L',
      imageUrl: 'https://images.unsplash.com/photo-1502005229762-cf1b2da7c9fb?q=80&w=1200&auto=format&fit=crop',
      badge: 'Verified',
    ),
    PropertyItem(
      id: 'v6',
      title: '1 BHK in Khar West',
      location: 'Mumbai',
      price: '₹1.35 Cr',
      imageUrl: 'https://images.unsplash.com/photo-1459535653751-d571815e906b?q=80&w=1200&auto=format&fit=crop',
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
    PropertyItem(
      id: 'n3',
      title: 'Blue Meadows',
      location: 'Panvel, Navi Mumbai',
      price: '₹55 L onwards',
      imageUrl: 'https://images.unsplash.com/photo-1444418776041-9c7e33cc5a9c?q=80&w=1200&auto=format&fit=crop',
      badge: 'New Project',
    ),
    PropertyItem(
      id: 'n4',
      title: 'Sunrise Heights',
      location: 'Miyapur, Hyderabad',
      price: '₹62 L onwards',
      imageUrl: 'https://images.unsplash.com/photo-1479839672679-a46483c0e7c8?q=80&w=1200&auto=format&fit=crop',
      badge: 'New Project',
    ),
    PropertyItem(
      id: 'n5',
      title: 'Palm View Residences',
      location: 'Golf Course Ext., Gurgaon',
      price: '₹1.25 Cr onwards',
      imageUrl: 'https://images.unsplash.com/photo-1428908728789-d2de25dbd4e2?q=80&w=1200&auto=format&fit=crop',
      badge: 'New Project',
    ),
    PropertyItem(
      id: 'n6',
      title: 'Willow Springs',
      location: 'Kondhwa, Pune',
      price: '₹78 L onwards',
      imageUrl: 'https://images.unsplash.com/photo-1523217582562-09d0def993a6?q=80&w=1200&auto=format&fit=crop',
      badge: 'New Project',
    ),
  ];

  static final List<String> spotlightBanners = [
    'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?q=80&w=1600&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1507089947368-19c1da9775ae?q=80&w=1600&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1449844908441-8829872d2607?q=80&w=1600&auto=format&fit=crop',
  ];
}

