package com.inspur.cams.bpt.base.domain.support;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.bpt.base.dao.IBptPeopleDemobilizedIllnessDao;
import com.inspur.cams.bpt.base.data.BptPeopleDemobilizedIllness;
import com.inspur.cams.bpt.base.domain.IBptPeopleDemobilizedIllnessDomain;
/**
 * 带病回乡退伍军人Domain
 * @author 王宝才
 *
 */

public class BptPeopleDemobilizedIllnessDomain implements IBptPeopleDemobilizedIllnessDomain{

	@Reference
	private IBptPeopleDemobilizedIllnessDao  demobilizedIllnessDao;
	
	/**
	 * 添加带病回乡退伍军人
	 */
	public void insert(BptPeopleDemobilizedIllness bptPeopleDemobilizedIllness) {
		List list = new ArrayList();
		list.add(bptPeopleDemobilizedIllness);
		demobilizedIllnessDao.save(list);
	}
	
	/**
	 * 查询带病回乡退伍军人信息
	 */
	public DataSet query(ParameterSet pset){
		return demobilizedIllnessDao.query(pset);
	}

	public void updateBptPeopleDemobilizedIllness(BptPeopleDemobilizedIllness bptPeopleDemobilizedIllness) {
		// TODO Auto-generated method stub
		demobilizedIllnessDao.update(bptPeopleDemobilizedIllness);
	}
}