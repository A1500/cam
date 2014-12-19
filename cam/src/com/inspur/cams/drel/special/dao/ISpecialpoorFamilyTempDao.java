package com.inspur.cams.drel.special.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.drel.special.data.SpecialpoorFamilyTemp;

/**
 * @title:ISpecialpoorFamilyTempDao
 * @description:
 * @author:
 * @since:2013-08-09
 * @version:1.0
*/
 public interface ISpecialpoorFamilyTempDao extends BaseCURD<SpecialpoorFamilyTemp>{
	public void save(List<SpecialpoorFamilyTemp> list);
}

