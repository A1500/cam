package com.inspur.cams.drel.sam.domain;



import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.comm.baseinfo.data.BaseinfoPeople;
import com.inspur.cams.drel.sam.data.SamPeopleAccident;
import com.inspur.cams.drel.sam.data.SamPeopleDisability;
import com.inspur.cams.drel.sam.data.SamPeopleDisease;
import com.inspur.cams.drel.sam.data.SamPeopleEdu;
/**
 * @title:IBaseinfoPeopleDomain
 * @description:
 * @author:
 * @since:2011-04-19
 * @version:1.0
*/
 public interface IBaseinfoPeopleDomain {
    public void save(List<BaseinfoPeople> list);

    public void saveYgjzJtxxCyxx(List<BaseinfoPeople> list);
	public void saveYgjzCyxxCjxxList(BaseinfoPeople ygjzjtxxcyxx);
	public void saveYgjzCyxxJyxxList(List<SamPeopleEdu> list);

	public void saveYgjzCyxxJyxx(List<SamPeopleEdu> list);
	public void saveYgjzCyxxCjxx(List<SamPeopleDisability> list);
	public void saveYgjzCyxxHbxx(List<SamPeopleDisease> list);
	public void saveYgjzCyxxSgxx(List<SamPeopleAccident> list);

	public DataSet queryCyxxCjxx(ParameterSet pset);
	public DataSet queryCyxxJyxx(ParameterSet pset);
	public DataSet queryCyxxHbxx(ParameterSet pset);
	public DataSet queryCyxxSgxx(ParameterSet pset);

 }