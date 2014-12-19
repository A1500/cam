package com.inspur.cams.drel.sam.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.drel.sam.data.SamPeopleDisease;
/**
 * @title:患病
 * @description:
 * @author:
 * @since:2011-04-25
 * @version:1.0
*/
 public interface ISamPeopleDiseaseDao extends BaseCURD<SamPeopleDisease>{
	public void save(List<SamPeopleDisease> list);

	public void batchDeleteByYgjzJtxxCyxx(String[] cyid);

}

