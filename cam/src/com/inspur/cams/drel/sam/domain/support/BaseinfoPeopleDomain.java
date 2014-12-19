package com.inspur.cams.drel.sam.domain.support;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.baseinfo.dao.IBaseinfoPeopleDao;
import com.inspur.cams.comm.baseinfo.data.BaseinfoPeople;
import com.inspur.cams.drel.sam.dao.ISamPeopleAccidentDao;
import com.inspur.cams.drel.sam.dao.ISamPeopleDisabilityDao;
import com.inspur.cams.drel.sam.dao.ISamPeopleDiseaseDao;
import com.inspur.cams.drel.sam.dao.ISamPeopleEduDao;
import com.inspur.cams.drel.sam.data.SamPeopleAccident;
import com.inspur.cams.drel.sam.data.SamPeopleDisability;
import com.inspur.cams.drel.sam.data.SamPeopleDisease;
import com.inspur.cams.drel.sam.data.SamPeopleEdu;
import com.inspur.cams.drel.sam.domain.IBaseinfoPeopleDomain;

/**
 * @title:BaseinfoPeopleDomain
 * @description:
 * @author:
 * @since:2011-04-19
 * @version:1.0
*/
 public class BaseinfoPeopleDomain implements IBaseinfoPeopleDomain {
	 @Reference
	private IBaseinfoPeopleDao baseinfoPeopleDao;
	//残疾信息
	@Reference
	private ISamPeopleDisabilityDao SamPeopleDisabilityDao;
	//教育信息
	@Reference
	private ISamPeopleEduDao SamPeopleEduDao;
	//患病信息
	@Reference
	private ISamPeopleDiseaseDao SamPeopleDiseaseDao;
	//事故信息
	@Reference
	private ISamPeopleAccidentDao SamPeopleAccidentDao;


	public void saveYgjzCyxxCjxxList(BaseinfoPeople ygjzjtxxcyxx) {
		List ygjzjtxxcyxxList = new ArrayList();
		ygjzjtxxcyxxList.add(ygjzjtxxcyxx);
		baseinfoPeopleDao.save(ygjzjtxxcyxxList);

	}

	public DataSet queryYgjzJtxxCyxx(ParameterSet pset) {
		return baseinfoPeopleDao.query(pset);
	}

	public void save(List<BaseinfoPeople> list) {
		baseinfoPeopleDao.save(list);

	}
	//新增成员保存
	public void saveYgjzJtxxCyxx(List<BaseinfoPeople> list) {
		this.baseinfoPeopleDao.save(list);
	}

	public IBaseinfoPeopleDao getYgjzjtxxcyxxDao() {
		return baseinfoPeopleDao;
	}

	public void setYgjzjtxxcyxxDao(IBaseinfoPeopleDao ygjzjtxxcyxxDao) {
		this.baseinfoPeopleDao = ygjzjtxxcyxxDao;
	}

	/**
	 * 家庭成员添加
	 *
	 */
	/*public void saveYgjzCyxxJyxxList(BaseinfoPeople ygjzjtxxcyxx) {
		List ygjzjtxxcyxxList = new ArrayList();
		ygjzjtxxcyxxList.add(ygjzjtxxcyxx);
		this.baseinfoPeopleDao.save(ygjzjtxxcyxxList);
	}*/

    //成员教育信息保存
	public void saveYgjzCyxxJyxx(List<SamPeopleEdu> list) {
		if (list != null && !list.isEmpty()) {
			this.SamPeopleEduDao.save(list);
		}

	}
	//成员残疾信息保存
	public void saveYgjzCyxxCjxx(List<SamPeopleDisability> list) {
		if (list != null && !list.isEmpty()) {
			this.SamPeopleDisabilityDao.save(list);
		}
	}
	//成员患病信息保存
	public void saveYgjzCyxxHbxx(List<SamPeopleDisease> list) {
		if (list != null && !list.isEmpty()) {
			this.SamPeopleDiseaseDao.save(list);
		}

	}

	//成员事故信息保存
	public void saveYgjzCyxxSgxx(List<SamPeopleAccident> list) {
		if (list != null && !list.isEmpty()) {
			this.SamPeopleAccidentDao.save(list);
		}
	}
    //成员教育信息保存，从变更页面保存
	public void saveYgjzCyxxJyxxList(List<SamPeopleEdu> line) {
		/*List ygjzjtxxcyxxList = new ArrayList();
		ygjzjtxxcyxxList.add(ygjzjtxxcyxx);
		this.baseinfoPeopleDao.save(ygjzjtxxcyxxList);*/
		if (line != null && !line.isEmpty()) {
			this.SamPeopleEduDao.save(line);
		}
	}
	// 查询残疾信息
	public DataSet queryCyxxCjxx(ParameterSet pset) {
		return SamPeopleDisabilityDao.query(pset);
	}
	// 查询教育信息
	public DataSet queryCyxxJyxx(ParameterSet pset) {
		return SamPeopleEduDao.query(pset);
	}
	// 查询患病信息
	public DataSet queryCyxxHbxx(ParameterSet pset) {
		return SamPeopleDiseaseDao.query(pset);
	}
	// 查询事故信息
	public DataSet queryCyxxSgxx(ParameterSet pset) {
		return SamPeopleAccidentDao.query(pset);
	}
}