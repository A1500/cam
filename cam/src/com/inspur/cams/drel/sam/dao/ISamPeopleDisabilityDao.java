package com.inspur.cams.drel.sam.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.drel.sam.data.SamPeopleDisability;
/**
 * @title:残疾
 * @description:
 * @author:
 * @since:2011-04-19
 * @version:1.0
*/
 public interface ISamPeopleDisabilityDao extends BaseCURD<SamPeopleDisability>{
	public void save(List<SamPeopleDisability> list);



}

