package com.inspur.cams.sorg.check.checkpublicbenefit.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.sorg.check.checkpublicbenefit.data.SomCheckPublicBenefit;

/**
 * @title:ISomCheckPublicBenefitDao
 * @description:
 * @author:
 * @since:2012-02-13
 * @version:1.0
*/
 public interface ISomCheckPublicBenefitDao extends BaseCURD<SomCheckPublicBenefit>{
	public void save(List<SomCheckPublicBenefit> list);
}

