package com.inspur.sdmz.jtxx.domain;



import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.sdmz.jtxx.data.SamPeopleDisability;
import com.inspur.sdmz.jtxx.data.BaseinfoPeople;


/**
 * @title:IYgjzJtxxCyxxDomain
 * @description:
 * @author:
 * @since:2011-04-19
 * @version:1.0
*/
 public interface IYgjzCyxxCjxxDomain {
    public void save(List<BaseinfoPeople> list);

    public void saveYgjzJtxxCyxx(List<BaseinfoPeople> list);
	public void saveYgjzCyxxCjxx(List<SamPeopleDisability> list);
	public DataSet queryYgjzCyxxCjxx(ParameterSet pset);
	public void saveYgjzCyxxCjxxList(BaseinfoPeople ygjzjtxxcyxx, List<SamPeopleDisability> list);





	public DataSet queryYgjzJtxxCyxx(ParameterSet pset);



 }