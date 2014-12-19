package com.inspur.cams.drel.special.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.drel.special.data.SpecialpoorPeople;

/**
 * @title:ISpecialpoorPeopleDao
 * @description:
 * @author:
 * @since:2013-08-09
 * @version:1.0
*/
 public interface ISpecialpoorPeopleDao extends BaseCURD<SpecialpoorPeople>{
	public void save(List<SpecialpoorPeople> list);

	public void deleteAll(String familyId);
}

