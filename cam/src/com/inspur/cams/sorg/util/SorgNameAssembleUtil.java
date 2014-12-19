package com.inspur.cams.sorg.util;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.comm.diccity.dao.jdbc.DicCityDao;
import com.inspur.cams.comm.util.BspUtil;

public class SorgNameAssembleUtil  extends BaseQueryCommand {
	private DicCityDao dicCityDao = (DicCityDao) DaoFactory
	.getDao("com.inspur.cams.comm.diccity.dao.jdbc.DicCityDao");
	public DataSet getPrefix(){
		DataSet ds = new DataSet();
		String areaCode = BspUtil.getCorpOrgan().getOrganCode();//当前登录行政区划
		String organName = BspUtil.getCorpOrgan().getOrganName();//当前登录行政区划
		String organType = BspUtil.getCorpOrgan().getOrganType();
		String suffix = "";
		//11：省
		if(organType.equals("11")){
			suffix = "省";
			String[] str = organName.split("省");
			prefixBuildDsProvince(str,suffix,ds);

		}
		//12：市
		if(organType.equals("12")){
			suffix = "市";
			String[] str = organName.split("市");
			prefixBuildDsCity(str,suffix,ds);
		}
		//13：县
		if(organType.equals("13")){
			if( organName.split("县").length>1){
				suffix = "县";
				String[] str = organName.split("县");
				prefixBuildDs(str,suffix,ds);
			}
			if( organName.split("区").length>1){
				suffix = "区";
				String[] str = organName.split("区");
				prefixBuildDs(str,suffix,ds);
			}
			if( organName.split("市").length>1){
				suffix = "市";
				String[] str = organName.split("市");
				prefixBuildDs(str,suffix,ds);
			}
		}
		return ds;
	}
	/**
	 * 省级前缀增加方法
	 * @param str
	 * @param suffix
	 * @param ds
	 */
	private static void prefixBuildDsProvince(String[] str,String suffix,DataSet ds){
		Record rd = new Record();
		rd.set("code", str[0]);
		rd.set("content", str[0]);
		ds.add(rd);
		Record rdWithSuffix = new Record();
		rdWithSuffix.set("code", str[0]+suffix);
		rdWithSuffix.set("content", str[0]+suffix);
		ds.add(rdWithSuffix);
		Record rdQiLu = new Record();
		rdQiLu.set("code", "齐鲁");
		rdQiLu.set("content", "齐鲁");
		ds.add(rdQiLu);
		Record rdLu = new Record();
		rdLu.set("code", "鲁");
		rdLu.set("content", "鲁");
		ds.add(rdLu);
	}

	private static void prefixBuildDsCity(String[] str,String suffix,DataSet ds){
		Record rd = new Record();
		rd.set("code", str[0]);
		rd.set("content", str[0]);
		ds.add(rd);
		Record rdWithSuffix = new Record();
		rdWithSuffix.set("code", str[0]+suffix);
		rdWithSuffix.set("content", str[0]+suffix);
		ds.add(rdWithSuffix);
	}
	private  void prefixBuildDs(String[] str,String suffix,DataSet ds){
		//对于区县的，如社团名称，前面的选项里只有环翠和环翠区，但是团成立应该是威海市环翠区
		String tempOrganCode = BspUtil.getCorpOrgan().getOrganCode().substring(0,4)+"00000000";
		String organNamePre = dicCityDao.getOrganNameById(tempOrganCode);
		Record rd = new Record();
		rd.set("code", str[0]);
		rd.set("content", str[0]);
		ds.add(rd);
		Record rdWithSuffix = new Record();
		rdWithSuffix.set("code", str[0]+suffix);
		rdWithSuffix.set("content", str[0]+suffix);
		ds.add(rdWithSuffix);
		Record rdCitySuffix = new Record();
		rdCitySuffix.set("code", str[0]+suffix);
		rdCitySuffix.set("content", organNamePre+str[0]+suffix);
		ds.add(rdCitySuffix);
	}

	public DataSet getSuffix(){
		DataSet ds = new DataSet();
		Record rd1 = new Record();
		rd1.set("code", "学会");
		rd1.set("content", "学会");
		ds.add(rd1);
		Record rd2 = new Record();
		rd2.set("code", "研究会");
		rd2.set("content", "研究会");
		ds.add(rd2);
		Record rd3 = new Record();
		rd3.set("code", "工业协会");
		rd3.set("content", "工业协会");
		ds.add(rd3);
		Record rd4 = new Record();
		rd4.set("code", "行业协会");
		rd4.set("content", "行业协会");
		ds.add(rd4);
		Record rd5 = new Record();
		rd5.set("code", "同业工会");
		rd5.set("content", "同业工会");
		ds.add(rd5);
		Record rd6 = new Record();
		rd6.set("code", "商会");
		rd6.set("content", "商会");
		ds.add(rd6);
		Record rd7 = new Record();
		rd7.set("code", "协会");
		rd7.set("content", "协会");
		ds.add(rd7);
		Record rd8 = new Record();
		rd8.set("code", "促进会");
		rd8.set("content", "促进会");
		ds.add(rd8);
		Record rd9 = new Record();
		rd9.set("code", "联合会");
		rd9.set("content", "联合会");
		ds.add(rd9);
		Record rd10 = new Record();
		rd10.set("code", "联谊会");
		rd10.set("content", "联谊会");
		ds.add(rd10);
		return ds;
	}

	public static void main(String[] args){
		String organName = "长清区民政局";
		String suffix = "";
		System.out.println("县"+organName.split("县").length);
		System.out.println("区"+organName.split("区").length);
		System.out.println("市"+organName.split("市").length);
	}
}
