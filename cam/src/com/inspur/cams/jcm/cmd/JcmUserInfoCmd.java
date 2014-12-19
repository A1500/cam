package com.inspur.cams.jcm.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.jcm.data.JcmUserInfo;
import com.inspur.cams.jcm.domain.IJcmUserInfoDomain;

/**
 * 用户表cmd
 * @author 
 * @date 2014-05-16
 */
public class JcmUserInfoCmd extends BaseAjaxCommand {

	private IJcmUserInfoDomain jcmUserInfoDomain = ScaComponentFactory
			.getService(IJcmUserInfoDomain.class, "jcmUserInfoDomain/jcmUserInfoDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		JcmUserInfo jcmUserInfo = (JcmUserInfo) record.toBean(JcmUserInfo.class);
		jcmUserInfoDomain.insert(jcmUserInfo);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		JcmUserInfo jcmUserInfo = (JcmUserInfo) record.toBean(JcmUserInfo.class);
		jcmUserInfoDomain.update(jcmUserInfo);
	}
	
	// 删除
	public void delete() {
		String userInfoId = (String) getParameter("userInfoId");
		jcmUserInfoDomain.delete(userInfoId);
	}
	
}