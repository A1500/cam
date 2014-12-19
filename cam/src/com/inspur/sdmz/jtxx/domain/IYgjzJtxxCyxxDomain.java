package com.inspur.sdmz.jtxx.domain;



import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.sdmz.jtxx.data.SamPeopleDisability;
import com.inspur.sdmz.jtxx.data.SamPeopleDisease;
import com.inspur.sdmz.jtxx.data.SamPeopleEdu;
import com.inspur.sdmz.jtxx.data.SamPeopleAccident;
import com.inspur.sdmz.jtxx.data.BaseinfoPeople;


/**
 * @title:IYgjzJtxxCyxxDomain
 * @description:
 * @author:
 * @since:2011-04-19
 * @version:1.0
*/
 public interface IYgjzJtxxCyxxDomain {
    public void save(List<BaseinfoPeople> list);
    @Trans
    public void saveYgjzJtxxCyxx(List<BaseinfoPeople> list);
    @Trans
	public void saveYgjzCyxxCjxx(List<SamPeopleDisability> list);
	@Trans
	public DataSet queryYgjzCyxxCjxx(ParameterSet pset);
	public void saveYgjzCyxxCjxxList(BaseinfoPeople ygjzjtxxcyxx, List<SamPeopleDisability> list);
	@Trans
	public DataSet queryYgjzCyxxJyxx(ParameterSet pset);
	public DataSet queryYgjzJtxxCyxx(ParameterSet pset);
	@Trans
	public void saveYgjzCyxxJyxx(List<SamPeopleEdu> list);
	@Trans
	public void saveYgjzCyxxHbxx(List<SamPeopleDisease> list);
	@Trans
	public DataSet queryYgjzCyxxHbxx(ParameterSet pset);
	public void saveYgjzCyxxHbxxList(BaseinfoPeople ygjzjtxxcyxx, List<SamPeopleDisease> list);

	@Trans
	public void saveYgjzCyxxSgxx(List<SamPeopleAccident> list);
	@Trans
	public DataSet queryYgjzCyxxSgxx(ParameterSet pset);
	public void saveYgjzCyxxSgxxList(BaseinfoPeople ygjzjtxxcyxx, List<SamPeopleAccident> list);

	public void saveYgjzCyxxJyxxList(BaseinfoPeople ygjzjtxxcyxx, List<SamPeopleEdu> list);

 }