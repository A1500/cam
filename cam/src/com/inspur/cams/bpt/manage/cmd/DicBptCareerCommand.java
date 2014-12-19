package com.inspur.cams.bpt.manage.cmd;

import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.Enumeration;
import java.util.Properties;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseAjaxCommand;

import com.inspur.cams.bpt.base.dao.jdbc.DicBptCareerDao;
import com.inspur.cams.bpt.base.data.DicBptCareer;
import com.inspur.cams.comm.diccity.dao.jdbc.DicCityDao;
import com.inspur.cams.comm.diccity.data.DicCity;
import com.inspur.cams.comm.util.IdHelp;

/**
 * 行政区划command
 * 
 * @author zhanghui
 * 
 */
public class DicBptCareerCommand extends BaseAjaxCommand {

	DicBptCareerDao dao = (DicBptCareerDao) DaoFactory
			.getDao("com.inspur.cams.bpt.base.dao.jdbc.DicBptCareerDao");
	
	
	
}
