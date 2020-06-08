import 'package:covid_buster_lite/logic/models/profile.dart';
import 'package:covid_buster_lite/services/common/database.dart';
import 'package:covid_buster_lite/services/profile/profile_service.dart';
import 'package:sembast/sembast.dart';
import 'package:uuid/uuid.dart';

class ProfileServiceImpl implements ProfileService {
  static const String PROFILE_STORE_NAME = 'Profiles';
  final _profileStore = intMapStoreFactory.store(PROFILE_STORE_NAME);

  Future<Database> get _db async => await AppDatabase.instance.database;
  @override
  Future<int> createProfile() async {
    //******************* TODO
    int _id = 1;
    var uuid = Uuid();

    Profile newProfile = Profile(id: _id, idString: uuid.v4());
    await _profileStore.record(_id).put(await _db, newProfile.toMap());
    return _id;
  }

  Future<List<Profile>> getAllProfiles() async {
    final finder = Finder();
    final profileSnapshots = await _profileStore.find(
      await _db,
      finder: finder,
    );

    List<Profile> profiles = profileSnapshots.map((snapshot) {
      final profile = Profile.fromMap(snapshot.value);
      return profile;
    }).toList();
    return profiles;
  }

  @override
  Future<Profile> getProfile() async {
    // ********************************** TODO
    var record = await _profileStore.record(1).get(await _db);
    print("Record: " + record.toString()); // json of Profile object
    Profile profile;
    if (record == null) {
      int id = await createProfile();
      record = await _profileStore.record(id).get(await _db);
    }
    profile = Profile.fromMap(record);
    print("Profile id: " + profile.id.toString());
    return profile;
  }

  @override
  Future<void> saveProfile(Profile profile) async {
//    print("Saving Active Profile, id: " + _activeProfile.id.toString());
//    print("Saving Active Profile, name: " + _activeProfile.name.toString());

    // Create a finder to isolate this Profile for update, by key (id).
    final finder = Finder(filter: Filter.byKey(profile.id));

    await _profileStore.update(await _db, profile.toMap(), finder: finder);
    return;
  }
}
