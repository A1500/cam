package com.inspur.cams.sorg.base.cmd;

import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.base.domain.ISomBorgChangeDomain;

/**
 * @title:业务主管单位变更cmd
 * @description:
 * @author:
 * @since:2013-03-05
 * @version:1.0
 */
public class SomBorgChangeCmd extends BaseAjaxCommand {
	private ISomBorgChangeDomain somBorgChangeDomain = ScaComponentFactory
			.getService(ISomBorgChangeDomain.class,
					"somBorgChangeDomain/somBorgChangeDomain");
	/**
	 * 查询数量
	 * @return
	 */
	public void queryCount() {
		ParameterSet pset = getParameterSet();
		int changeCount=somBorgChangeDomain.queryCount(pset);
		setReturn("changeCount", changeCount);
	}
	
	/**
	 * 查询变更数量
	 * @return
	 */
	public void queryBeforeCount() {
		ParameterSet pset = getParameterSet();
		int changeBeforeCount=somBorgChangeDomain.queryBeforeCount(pset).getCount();
		setReturn("changeBeforeCount", changeBeforeCount);
	}
	
	/**
	 * 当前业务主管单位名称
	 * @return
	 */
	public void nowBorgName(){
		ParameterSet pset = getParameterSet();
		String borgName=somBorgChangeDomain.nowBorgName(pset);
		setReturn("borgName", borgName);
	}
}
