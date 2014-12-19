package com.inspur.cams.drel.sam.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.drel.sam.data.SamPeopleExtend;

/**
 * @title:人员扩展信息（低保用）Dao
 * @description:
 * @author:	yanll
 * @since:2012-05-03
 * @version:1.0
*/
 public interface ISamPeopleExtendDao extends BaseCURD<SamPeopleExtend>{
	public void save(List<SamPeopleExtend> list);

	/**
	 * 根据人员id删除人员扩展信息
	 * @param peopleId
	 */
	public void deleteByPeopleId(String peopleId);
}

