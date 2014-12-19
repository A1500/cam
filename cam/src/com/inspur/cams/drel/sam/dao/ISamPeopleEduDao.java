package com.inspur.cams.drel.sam.dao;


import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.drel.sam.data.SamPeopleEdu;
/**
 * @title:教育
 * @description:
 * @author:
 * @since:2011-04-25
 * @version:1.0
*/
 public interface ISamPeopleEduDao extends BaseCURD<SamPeopleEdu>{
	public void save(List<SamPeopleEdu> list);

	public void batchDeleteByYgjzJtxxCyxx(String[] cyid);

}

