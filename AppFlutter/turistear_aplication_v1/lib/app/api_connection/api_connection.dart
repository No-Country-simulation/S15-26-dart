class API {
  //localhost:3001
  static const hostConnect = "localhost:3001/v1";

  // User
  static const user = '$hostConnect/user';
  static const signUp = '$user/signup';
  static const validateEmail = '$user/validateEmail';
  static const login = '$user/login';
  static const results = '$user/';
  static const updatePass = '$user/updatePassword';
  static const validateOldPass = '$user/validateOldPass';

  //Predio
  static const predio = '$hostConnect/predio';
  static const validatePredio = '$predio/validatePredio';
  static const registerPredio = '$predio/createPredio';

  //Servicio
  static const servicio = '$hostConnect/servicio';
  static const servicioubic = '$servicio/ubicacion';
  static const serviciosEstablecimiento = '$servicio/servicios';
  static const validateServicio = '$servicio/validateServicio';
  static const registerServicio = '$servicio/createServicio';

  //Modem
  static const modem = '$hostConnect/modem';
  static const validateMacSn = '$modem/validateMacSn';
  static const registerModem = '$modem/createModem';

  //Establecimiento
  static const establecimiento = '$hostConnect/establecimiento';
  static const validateEstablecimiento =
      '$establecimiento/validateEstablecimiento';
  static const registerEstablecimiento =
      '$establecimiento/createEstablecimiento';
  static const adressEstablecimiento = '$establecimiento/adress';

  //Empresa
  static const empresa = '$hostConnect/empresa';

  //CPC
  static const cpc = '$hostConnect/cpc';
}
