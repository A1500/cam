package com.inspur.cams.sorg.base.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.sorg.base.data.SomOffice;

/**
 * 社会组织内设机构dao接口
 * @author shgtch
 * @date 2011-5-11
 */
public interface ISomOfficeDao extends BaseCURD<SomOffice> {
	 
	public void save(List<SomOffice> list);
	
	public void delByTaskCode(String taskCode);
}

