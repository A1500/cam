package com.inspur.cams.drel.sam.dao;


import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.drel.sam.data.SamPeopleAccident;

/**
 * @title:事故
 * @description:
 * @author:
 * @since:2011-04-25
 * @version:1.0
*/
 public interface ISamPeopleAccidentDao extends BaseCURD<SamPeopleAccident>{
	public void save(List<SamPeopleAccident> list);

	public void batchDeleteByYgjzJtxxCyxx(String[] cyid);

}

