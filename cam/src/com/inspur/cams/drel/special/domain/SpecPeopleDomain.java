package com.inspur.cams.drel.special.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;
import com.inspur.cams.drel.special.dao.ISpecialpoorPeopleDao;
import com.inspur.cams.drel.special.data.SpecialpoorPeople;

/**
 * SpecPeopleDomain
 * @description:
 * @author:
 * @since:2012-05-18
 * @version:1.0
*/
public class SpecPeopleDomain implements ISpecPeopleDomain {
	@Reference
	private ISpecialpoorPeopleDao specialpoorPeopleDao;

	public DataSet query(ParameterSet pset) {
		return specialpoorPeopleDao.query(pset);
	}

	public void insert(SpecialpoorPeople people) {
		specialpoorPeopleDao.insert(people);
		
	}

	public void deleteAll(String familyId) {
		specialpoorPeopleDao.deleteAll(familyId);
		
	}
}
