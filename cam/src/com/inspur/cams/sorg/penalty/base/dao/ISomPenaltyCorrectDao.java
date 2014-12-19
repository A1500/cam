package com.inspur.cams.sorg.penalty.base.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.sorg.penalty.base.data.SomPenaltyCorrect;

/**
 * @title:ISomPenaltyCorrectDao
 * @description:
 * @author:
 * @since:2011-12-29
 * @version:1.0
*/
 public interface ISomPenaltyCorrectDao extends BaseCURD<SomPenaltyCorrect>{
	public void save(List<SomPenaltyCorrect> list);
}

