package com.inspur.cams.comm.userExt.imp;

 
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.loushang.bsp.eai.pap.user.data.UserView;
import org.loushang.bsp.permit.pap.user.domain.IUserListenter;
import org.loushang.bsp.util.BspConfig;
import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.Record;

import com.inspur.cams.comm.userExt.data.PubUsersExt;

/**
 * @author licb
 * @date:2011-10-27 上午09:02:49
 * @version : UserExtImp.java
 */
@SuppressWarnings("unchecked")
public class UserExtImp implements IUserListenter {
	EntityDao<PubUsersExt> dao = (EntityDao<PubUsersExt>) DaoFactory
			.getDao("com.inspur.cams.comm.userExt.dao.PubUsersExtDao");

	/**
	 * 增加用户扩展信息
	 * 
	 * @param ps
	 *            从界面获得的参数集
	 */
	@SuppressWarnings("unchecked")
	public void create(Map params) { 
		Record r = (Record) params.get("userExtParamters");
		Record record = (Record) params.get("record");
		UserView userView = (UserView) record.toBean(UserView.class);
		if (r != null) {
			PubUsersExt ue = (PubUsersExt) r.toBean(PubUsersExt.class);
			String userId = userView.getUserId();
			String caseSensitiveFlag = BspConfig
					.getString("bsp.userId_case_sensitive");
			if (caseSensitiveFlag == null
					|| !caseSensitiveFlag.equalsIgnoreCase("true")) {
				userId = userId.toUpperCase();
				ue.setUserId(userId);
			}
			if (caseSensitiveFlag.equalsIgnoreCase("true")) {
				ue.setUserId(userId);
			}
			dao.insert(ue);
		}
	}

	/**
	 * 删除用户扩展信息
	 * 
	 * @param String[]
	 *            userId 用户ID 数组
	 */
	public void delete(String[] userId) {
		dao.batchDelete(userId);
	}

	/**
	 * 修改用户扩展信息
	 * 
	 * @param ps
	 *            从界面获得的参数集
	 */
	@SuppressWarnings("unchecked")
	public void update(Map params) { 
		Record r = (Record) params.get("userExtParamters");
		if (r != null) {
			PubUsersExt ue = (PubUsersExt) r.toBean(PubUsersExt.class);
			List<PubUsersExt> list = new ArrayList<PubUsersExt>();
			list.add(ue);
			dao.save(list);
		}
	}
}
