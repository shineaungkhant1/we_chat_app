import '../data/vos/message_vo.dart';
import '../data/vos/user_vo.dart';

abstract class ChatDataAgent{
  /// Chat
  Future<void> sendMessage(MessageVO message,UserVO? userVO);
  Stream<List<MessageVO>> getMessages(String loggedInUserId,String sentUserId);
  
}