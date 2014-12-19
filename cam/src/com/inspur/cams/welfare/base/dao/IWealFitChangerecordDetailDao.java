package com.inspur.cams.welfare.base.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.welfare.base.data.WealFitChangerecordDetail;

/**
 * @title:IWealFitChangerecordDetailDao
 * @description:
 * @author:
 * @since:2013-04-19
 * @version:1.0
*/
 public interface IWealFitChangerecordDetailDao extends BaseCURD<WealFitChangerecordDetail>{
	public void save(List<WealFitChangerecordDetail> list);
}

