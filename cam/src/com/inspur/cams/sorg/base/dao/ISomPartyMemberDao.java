package com.inspur.cams.sorg.base.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.sorg.base.data.SomPartyMember;

/**
 * 社会组织党建党员dao接口
 * @author shgtch
 * @date 2011-8-18
 */
public interface ISomPartyMemberDao extends BaseCURD<SomPartyMember> {
	
	public void save(List<SomPartyMember> list);
	public void deleteBySorgId(String sorgId) ;
}
