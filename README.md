```java
package com.controller;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import com.dao.UserMessageDao;
import com.entity.UserAlive;
import com.entity.UserCount;
import com.entity.UserMessage;
import com.huanxin.core.tool.HuanXinUtil;
import com.service.UserMessageService;
import com.util.DateUtils;
import com.util.GetLocationByIpUtil;
import com.util.JSonUtil;
import com.util.RedisUtil;
import com.util.TokenUtils;
import redis.clients.jedis.Jedis;
 
@Controller
public class AutoLoginController {
	private final int ERRORCODE=1;
	private final int TRUECODE=0;
	@Autowired
	UserMessageService userMessageService;
	@Autowired
	UserMessageDao userMessageDao;
	/**
	 * @author 莫林
	 * @param int user_id,String token
	 * */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping("login/autoLogin/checkToken")
	public  void checkToken(HttpServletRequest request,HttpServletResponse response){
		response.setContentType("text/html;charset=utf-8");       //设置请求以及响应的内容类型以及编码方式
		response.setCharacterEncoding("UTF-8");
		String dwkToken = request.getParameter("dwkToken");
		//对用户状态进行校验
		@SuppressWarnings("rawtypes")
		Map map = new HashMap();
		@SuppressWarnings("rawtypes")
		Map sendMap = new HashMap();
		Jedis jedis = RedisUtil.getJedis();
		String[] separate=TokenUtils.separate(dwkToken);
		int userId = Integer.parseInt(separate[0]);
		Integer state = userMessageService.selectStateByUserId(userId);
		System.out.println(state);
		if (state != null && state != 2) {
			// 用户正常，进行token校验
			int status = TokenUtils.checkToken(separate[0], separate[1], jedis);
			if (status == 1) {
				// 校验成功
				UserMessage userMessage = new UserMessage();
				// 获取最后登录ip
				String remoteAddr = request.getRemoteAddr();
				// 获取当前时间
				Date date = DateUtils.createDate();
				userMessage.setLastLoginIp(remoteAddr);
				userMessage.setLastloginTime(date);
				userMessage.setUserId(userId);
				// 获取用户ip所在地区
				if(remoteAddr.equals("0:0:0:0:0:0:0:1")) {
					remoteAddr=null;
				}
				//判断用户类型
				//不是内部用户则更新用户登录地址
				if(!userMessageDao.isInnerUser(userId)) {
					String positonByIp = GetLocationByIpUtil.GetPositonByIp(remoteAddr);
					userMessage.setUserRegion(positonByIp);
				}
				
				// 执行更新操作
				// 校验成功，更新用户最后登录时间，最后登录ip
				userMessageService.updateUserIpAndTime(userMessage);
				map.put("message", "登录成功");
				sendMap.put("code", TRUECODE);
				sendMap.put("data", map);
				//获取用户信息，查询是否注册环信成功
				Map userInfo = userMessageService.getUserInfo(userId);
				String valueOf = String.valueOf(userInfo.get("searchId"));
				System.out.println("是否存在该环信用户"+HuanXinUtil.existByUserName(valueOf));
				if(!HuanXinUtil.existByUserName(valueOf)) {
					//重新注册环信
					//注册环信用户
					boolean userSave = HuanXinUtil.userSave(String.valueOf(valueOf),String.valueOf(valueOf));
					//retry
					System.out.println("第一次重新注册"+userSave);
					if(!userSave) {
						boolean userSave2 = HuanXinUtil.userSave(String.valueOf(valueOf),String.valueOf(valueOf));
						System.out.println("第二次重新注册"+userSave2);
					}
				}
				//插入用户活跃表
				UserAlive userAlive = new UserAlive();
				userAlive.setUserId(userId);
				Date dates = DateUtils.createDateWithNoTime(new Date());
				userAlive.setTime(dates);
				if(!userMessageDao.existAliveUser(userAlive)) {
					//插入用户活跃表
					userMessageDao.insertAliveUser(userAlive);
					if(userMessageDao.existUserCount(dates)){
						userMessageDao.updateAliveUser(dates);
					}else {
						UserCount userCount = new UserCount();
						userCount.setNewUser(0);
						userCount.setDayAliveUser(1);
						userCount.setTime(dates);
						userMessageDao.insertUserCount(userCount);
					}
				}
			} else if (status == 0) {
				// 校验失败，用户异地登录
				sendMap.put("code", ERRORCODE);
				map.put("message", "用户异地登录");
				sendMap.put("data", map);
			} else {
				// 用户token过期
				sendMap.put("code", ERRORCODE);
				map.put("message", "自动登录失效");
				sendMap.put("data", map);
			}
		} else {
			sendMap.put("code", ERRORCODE);
			map.put("message", "账户封停");
			sendMap.put("data", map);
		}
		RedisUtil.returnResource(jedis);
		JSonUtil.writeToClient(sendMap, response);
	}
}

```
