package com.inspur.cams.drel.special.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.drel.special.data.SpecialpoorPeople;

/**
 * @title:ISpecPeopleDomain
 * @description:
 * @version:1.0
 */
public interface ISpecPeopleDomain {
	public DataSet query(ParameterSet pset);

	public void insert(SpecialpoorPeople people);
	/**
	 * 
	 */
	public void deleteAll(String familyId);
}
