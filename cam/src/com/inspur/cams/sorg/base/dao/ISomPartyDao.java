package com.inspur.cams.sorg.base.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.sorg.base.data.SomParty;

/**
 * 社会组织党建dao接口
 * @author shgtch
 * @date 2011-8-18
 */
public interface ISomPartyDao extends BaseCURD<SomParty> {
	
	public void save(List<SomParty> list);
	
}
